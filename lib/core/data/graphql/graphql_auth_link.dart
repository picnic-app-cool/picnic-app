import 'dart:async';

import 'package:graphql/client.dart';
import 'package:picnic_app/core/data/graphql/auth_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_result.dart';
import 'package:picnic_app/core/data/graphql/refresh_auth_token_link.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/token_decoder_repository.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class GraphQLAuthLink extends Link {
  GraphQLAuthLink(
    this._authTokenRepository,
    this._tokenDecoderRepository,
    this._saveAuthTokenUseCase,
    this._getAuthTokenUseCase,
    this._refreshTokenClient,
    this._configProvider,
    this._logger,
  );

  static Completer<QueryResult<GqlAuthResult>>? _refreshCompleter;
  final AuthTokenRepository _authTokenRepository;
  final TokenDecoderRepository _tokenDecoderRepository;
  final SaveAuthTokenUseCase _saveAuthTokenUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GraphQLClient _refreshTokenClient;
  final EnvironmentConfigProvider _configProvider;
  final GraphQLLogger _logger;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    var req = request;

    final authInfo = await _authTokenRepository.getAuthToken().asyncFold(
          (fail) => const AuthToken.empty(),
          (success) => success,
        );

    var accessToken = authInfo.accessToken;
    final refreshToken = authInfo.refreshToken;

    if (accessToken.isNotEmpty &&
        refreshToken.isNotEmpty &&
        _tokenDecoderRepository.isExpired(accessToken) &&
        !_tokenDecoderRepository.isExpired(refreshToken)) {
      accessToken = await _refreshToken();
    }
    if (accessToken.isNotEmpty) {
      req = request.updateContextEntry<HttpLinkHeaders>(
        (HttpLinkHeaders? headers) {
          return HttpLinkHeaders(
            headers: <String, String>{
              // put oldest headers
              ...headers?.headers ?? <String, String>{},
              // and add a new headers
              'Authorization': 'Bearer $accessToken',
            },
          );
        },
      );
    }

    yield* forward!(req);
  }

  Future<String> _refreshToken() async {
    try {
      final response = await _performRefresh();

      return await _saveAuthTokenUseCase.execute(authToken: response.authToken).asyncFold(
        (fail) {
          return '';
        },
        (success) {
          return response.authToken.accessToken;
        },
      );
    } catch (ex) {
      return '';
    }
  }

  Future<QueryResult<GqlAuthResult>> _performRefresh() async {
    var completer = _refreshCompleter;
    if (completer?.isCompleted == false) {
      debugLog("There is already 'refreshToken' request in progress, waiting until its finished", this);
      //this makes sure we run only one refresh-token request at a time, so that if multiple concurrent requests fail,
      // we don't run the refresh token
      return completer!.future;
    }
    completer = Completer<QueryResult<GqlAuthResult>>();
    _refreshCompleter = completer;
    debugLog("Refreshing accessToken...", this);
    final tokensResult = await _getAuthTokenUseCase.execute();
    if (tokensResult.isFailure) {
      logError("fail when getting tokens from storage: ${tokensResult.getFailure()}", logToCrashlytics: false);
      completer.completeError(tokensResult.getFailure()!);
      return completer.future;
    }
    final tokenResult = tokensResult.getSuccess()!;
    if (tokenResult.accessToken.isEmpty) {
      logError("missing accessToken, nothing to refresh", logToCrashlytics: false);
      completer.completeError("Response is missing accessToken: $tokenResult");
      return completer.future;
    }
    var response = await _refreshTokenRequest(tokenResult);
    if (response.hasException) {
      logError(response.exception, logToCrashlytics: false);
      //yielding original's request exception, not the refresh token's one
      completer.completeError(response.exception!);
      return completer.future;
    }
    completer.complete(response);
    return completer.future;
  }

  Future<QueryResult<GqlAuthResult>> _refreshTokenRequest(AuthToken tokens) async {
    final variables = {
      'accessToken': tokens.accessToken,
      // for legacy purposes, users who don't have refresh token (the ones using the older version
      // of the app that didn't support refresh tokens)
      // can use their access token as refresh token and they'll receive proper refresh token in response
      'refreshToken': tokens.refreshToken.isEmpty ? tokens.accessToken : tokens.refreshToken,
    };
    final doc = refreshTokenMutation(
      includeDebugOption: await _configProvider.shouldUseShortLivedAuthTokens(),
    );
    final requestId = _logger.logRequest(doc: doc, vars: variables);
    final response = await _refreshTokenClient.mutate(
      MutationOptions(
        document: gql(
          doc,
        ),
        parserFn: (json) {
          return GqlAuthResult.fromJson((json['refreshTokens'] as Map).cast());
        },
        variables: variables,
      ),
    );
    response.isOptimistic;
    _logger.logResponse(requestId: requestId, result: response);
    return response;
  }
}

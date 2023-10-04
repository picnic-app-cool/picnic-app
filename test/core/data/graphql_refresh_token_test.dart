import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/graphql_client_factory.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_executor.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/data/feed_queries.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_auth_token_repository.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GraphQLExecutor client;
  late AuthTokenRepository authTokenRepo;

  test(
    '403 from backend should trigger refreshTokens',
    () async {
      when(() => Mocks.tokenDecoderRepository.isExpired(expiredAccessToken)).thenReturn(true);
      when(() => Mocks.tokenDecoderRepository.isExpired('refreshToken')).thenReturn(false);
      final feedsQueryFuture = _feedsQuery(client);
      _mockHttpResponses(
        Mocks.dioClient,
        authTokenRepo,
      );
      final result = await feedsQueryFuture;

      final requestsList = verify(
        () => Mocks.dioClient.post<dynamic>(
          any(),
          data: captureAny(named: 'data'),
          options: captureAny(named: 'options'),
          onSendProgress: any(named: 'onSendProgress'),
        ),
      ).captured;

      final tokenRefreshRequestData = requestsList[0] as Map<String, dynamic>;
      final query = tokenRefreshRequestData['query'] as String;
      final variables = tokenRefreshRequestData['variables'] as Map<String, dynamic>;
      expect(query.contains("mutation refreshTokens"), isNotNull);
      expect(variables['refreshToken'], 'refreshToken');
      expect(variables["accessToken"], expiredAccessToken);
      expect((requestsList[3] as dio.Options).headers!['Authorization'], "Bearer valid token");
      expect(result.isSuccess, true);
    },
  );

  setUp(() async {
    authTokenRepo = TestAuthTokenRepository();
    await authTokenRepo.saveAuthToken(
      const AuthToken(
        accessToken: expiredAccessToken,
        refreshToken: 'refreshToken',
      ),
    );
    getIt.registerFactory<SetAppInfoUseCase>(() => Mocks.setAppInfoUseCase);
    client = GraphQLExecutor(
      getIt(),
      getIt(),
      getIt(),
      GraphqlClientFactory(
        Mocks.environmentConfigProvider,
        authTokenRepo,
        Mocks.tokenDecoderRepository,
        const GraphQLFailureMapper(),
        SaveAuthTokenUseCase(authTokenRepo),
        GetAuthTokenUseCase(authTokenRepo),
        GraphQLLogger(Mocks.currentTimeProvider),
        Mocks.backgroundApiRepository,
        Mocks.appInfoStore,
        Mocks.setAppInfoUseCase,
        dioClient: Mocks.dioClient,
        store: gql.InMemoryStore(),
      ),
      getIt(),
      getIt(),
    );
    when(() => Mocks.environmentConfigProvider.getConfig())
        .thenAnswer((_) => getIt<EnvironmentConfigProvider>().getConfig());
    when(() => Mocks.environmentConfigProvider.shouldUseShortLivedAuthTokens()).thenAnswer((_) async => true);
    when(() => Mocks.environmentConfigProvider.getAdditionalGraphQLHeaders()).thenAnswer((_) => Future.value({}));
    when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
  });
}

Future<Either<GraphQLFailure, Map<String, dynamic>>> _feedsQuery(GraphQLExecutor client) async {
  final result = await client.query(
    document: getFeedsQuery,
    parseData: (json) => json,
  );

  return result.cacheableResult.result;
}

const expiredAccessToken = 'expired token';
const validAccessToken = 'valid token';

void _mockHttpResponses(
  dio.Dio dioClient,
  AuthTokenRepository authTokenRepository,
) {
  when(
    () => Mocks.dioClient.post<dynamic>(
      any(),
      data: any(named: 'data'),
      options: any(named: 'options'),
      onSendProgress: any(named: 'onSendProgress'),
    ),
  ).thenAnswer((invocation) {
    final data = (invocation.namedArguments[#data] ?? {}) as Map<String, dynamic>;
    final body = jsonEncode(data);
    final options = (invocation.namedArguments[#options] ?? dio.Options()) as dio.Options;
    final headers = options.headers ?? {};

    if (headers.entries.any((element) => (element.value as String).contains(expiredAccessToken))) {
      final response = dio.Response<Map<String, dynamic>>(
        data: {},
        requestOptions: dio.RequestOptions(),
        statusCode: 403,
      );
      return Future.value(response);
    }

    if (body.contains("refreshTokens")) {
      const newToken = AuthToken(accessToken: validAccessToken, refreshToken: 'refreshToken');
      authTokenRepository.saveAuthToken(newToken);
      final response = dio.Response<Map<String, dynamic>>(
        data: {
          "data": {
            "refreshTokens": {
              "authInfo": {"accessToken": newToken.accessToken, "refreshToken": newToken.refreshToken}
            }
          }
        },
        requestOptions: dio.RequestOptions(),
        statusCode: 200,
      );
      return Future.value(response);
    }

    final response = dio.Response<Map<String, dynamic>>(
      data: {
        "data": {
          "feedsConnection": {
            "pageInfo": {"hasNextPage": false, "hasPreviousPage": false},
            "edges": [
              {
                "cursorId": "71087365",
                "node": {"id": "71087365", "type": "CUSTOM", "name": "Custom Feed"}
              }
            ]
          }
        }
      },
      requestOptions: dio.RequestOptions(),
      statusCode: 200,
    );
    return Future.value(response);
  });
}

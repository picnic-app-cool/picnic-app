import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/graphql/dio_link/dio_link.dart';
import 'package:picnic_app/core/data/graphql/graphql_auth_link.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_headers_link.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/graphql_version_link.dart';
import 'package:picnic_app/core/data/graphql/refresh_auth_token_link.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/domain/repositories/token_decoder_repository.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/main.dart';

class GraphqlClientFactory {
  const GraphqlClientFactory(
    this._configProvider,
    this._authTokenRepository,
    this._tokenDecoderRepository,
    this._failureMapper,
    this._saveAuthTokenUseCase,
    this._getAuthTokenUseCase,
    this._logger,
    this._backgroundApiRepository,
    this._appInfoStore,
    this._setAppInfoUseCase, {
    this.dioClient,
    this.store,
  });

  //used for overriding in tests
  @visibleForTesting
  final Dio? dioClient;

  //used for overriding in tests
  final gql.Store? store;
  final AuthTokenRepository _authTokenRepository;
  final TokenDecoderRepository _tokenDecoderRepository;
  final EnvironmentConfigProvider _configProvider;
  final GraphQLFailureMapper _failureMapper;
  final SaveAuthTokenUseCase _saveAuthTokenUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GraphQLLogger _logger;
  final BackgroundApiRepository _backgroundApiRepository;
  final AppInfoStore _appInfoStore;
  final SetAppInfoUseCase _setAppInfoUseCase;

  //ignore: long-method
  Future<gql.GraphQLClient> createClient() async {
    final config = await _configProvider.getConfig();
    final baseUrl = config.baseGraphQLUrl;

    final dio = dioClient ?? Dio();
    final dioLink = DioLink(
      baseUrl,
      client: dio,
      backgroundApiRepository: _backgroundApiRepository,
    );
    // separate gql client to perform token refresh mutation,
    // with simplified link that does not do any query modifications
    final refreshTokenClient = _buildRefreshTokenClient(dioLink);
    return gql.GraphQLClient(
      link: gql.Link.from([
        RefreshAuthTokenLink(
          refreshTokenClient,
          _failureMapper,
          _configProvider,
          _saveAuthTokenUseCase,
          _getAuthTokenUseCase,
          _logger,
        ),
        GraphQLHeadersLink(_configProvider),
        GraphQLAuthLink(
          _authTokenRepository,
          _tokenDecoderRepository,
          _saveAuthTokenUseCase,
          _getAuthTokenUseCase,
          refreshTokenClient,
          _configProvider,
          _logger,
        ),
        GraphQLVersionLink(
          _appInfoStore,
          _setAppInfoUseCase,
        ),
        dioLink,
      ]),
      cache: gql.GraphQLCache(
        store: store ?? (isUnitTests ? gql.InMemoryStore() : await gql.HiveStore.open()),
      ),
    );
  }

  gql.GraphQLClient _buildRefreshTokenClient(gql.Link link) {
    return gql.GraphQLClient(
      link: link,
      cache: gql.GraphQLCache(),
      defaultPolicies: gql.DefaultPolicies(
        mutate: gql.Policies(
          fetch: gql.FetchPolicy.noCache,
        ),
      ),
    );
  }
}

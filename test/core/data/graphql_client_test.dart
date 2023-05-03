import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/graphql_client_factory.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/graphql_unauthenticated_failure_handler.dart';
import 'package:picnic_app/core/data/graphql/graphql_variables_processor.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_dependencies_configurator.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/domain/model/cache_policy.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/picnic_app_init_params.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_auth_token_repository.dart';
import '../../test_utils/test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GraphQLClient graphQLClient;
  const expiredAccessToken = 'expired access token';
  const expiredRefreshToken = 'expired refresh token';
  late SessionInvalidatedListenersContainer sessionsContainer;
  late TestAuthTokenRepository authTokenRepo;

  void _prepareMocks([void Function()? mocking]) {
    getIt.registerFactory<GraphQLIsolateDependenciesConfigurator>(
      () => TestGraphQLIsolateDependenciesConfigurator(
        authTokenRepo,
        mocking ?? () {},
      ),
    );

    graphQLClient = getIt();
  }

  test("should return result from cache first before network", () async {
    _prepareMocks();
    //pre-warm cache
    await graphQLClient
        .watchQuery(
          document: testQuery,
          parseData: (json) => json,
        )
        .networkResult;

    final queryStream = graphQLClient.watchQuery(
      document: testQuery,
      parseData: (json) {
        return json;
      },
      options: const WatchQueryOptions(
        cachePolicy: CachePolicy.cacheAndNetwork,
        continueWatchingAfterNetworkResponse: false,
        pollInterval: Duration.zero,
      ),
    );
    final results = await queryStream.take(100).toList();
    expect(results.length, 2);
    expect(results[0].source, CacheableSource.cache);
    expect(results[1].source, CacheableSource.network);
  });

  test(
    "should poll results if poll interval specified",
    () async {
      _prepareMocks();
      //pre-warm cache
      await graphQLClient.watchQuery(document: testQuery, parseData: (json) => json).networkResult;
      final queryStream = graphQLClient.watchQuery(
        document: testQuery,
        parseData: (json) {
          return json;
        },
        options: const WatchQueryOptions(
          cachePolicy: CachePolicy.cacheAndNetwork,
          continueWatchingAfterNetworkResponse: true,
          pollInterval: Duration(milliseconds: 1),
        ),
      );
      //pre-warm cache
      final events = await queryStream.take(10).toList();

      expect(events.length, 10);
      expect(events[0].source, CacheableSource.cache);
      for (var i = 1; i < 10; i++) {
        expect(
          events[i].source,
          CacheableSource.network,
          reason: "event at $i was not from network: ${events[i].source}",
        );
      }
    },
  );

  test('should log user out if refreshing token fails', () async {
    _prepareMocks(() {
      when(
        () => Mocks.dioClient.post<dynamic>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          onSendProgress: any(named: 'onSendProgress'),
        ),
      ).thenAnswer((invocation) async {
        final response = dio.Response<Map<String, dynamic>>(
          data: {
            "errors": [
              {
                "message": "rpc error: code = Unauthenticated desc = user unauthenticated",
                "path": ["chatFeedConnection"]
              }
            ],
            "data": null
          },
          requestOptions: dio.RequestOptions(),
          statusCode: 200,
        );
        return Future.value(response);
      });
    });
    var logoutCalled = false;
    sessionsContainer.registerOnSessionInvalidatedListener((_) {
      logoutCalled = true;
    });
    await authTokenRepo.saveAuthToken(
      const AuthToken(
        accessToken: expiredAccessToken,
        refreshToken: expiredRefreshToken,
      ),
    );

    final result = await graphQLClient.query(
      document: testQuery,
      parseData: (data) => data,
    );
    expect(result.isFailure, true);
    expect(logoutCalled, true);
  });

  setUp(() async {
    await configureDependenciesForTests();
    sessionsContainer = TestSessionInvalidatedListenersContainer();
    authTokenRepo = TestAuthTokenRepository();
    getIt.registerFactory<SessionInvalidatedListenersContainer>(() => sessionsContainer);
  });

  tearDown(() {
    graphQLClient.dispose();
  });
}

class TestGraphQLIsolateDependenciesConfigurator implements GraphQLIsolateDependenciesConfigurator {
  TestGraphQLIsolateDependenciesConfigurator(
    this.authTokenRepo,
    this.mocking,
  );

  final AuthTokenRepository authTokenRepo;
  final void Function() mocking;

  @override
  Future<void> configure(PicnicAppInitParams appInitParams) async {
    Mocks.init();
    await configureDependenciesForTests();
    getIt.registerLazySingleton<AuthTokenRepository>(() => authTokenRepo);
    getIt.registerFactory<GraphQLFailureMapper>(() => const GraphQLFailureMapper());

    getIt.registerFactory<GraphQLUnauthenticatedFailureHandler>(
      () => GraphQLUnauthenticatedFailureHandler(
        getIt(),
        authTokenRepo,
      ),
    );

    getIt.registerFactory<GraphQLVariablesProcessor>(() => GraphQLVariablesProcessor());

    getIt.registerFactory<GraphqlClientFactory>(
      () {
        return GraphqlClientFactory(
          getIt<EnvironmentConfigProvider>(),
          getIt.get<AuthTokenRepository>(),
          getIt.get<GraphQLFailureMapper>(),
          SaveAuthTokenUseCase(getIt.get<AuthTokenRepository>()),
          getIt.get<GetAuthTokenUseCase>(),
          getIt(),
          Mocks.backgroundApiRepository,
          dioClient: Mocks.dioClient,
          store: gql.InMemoryStore(),
        );
      },
    );

    getIt.registerFactory<GraphQLLogger>(
      () => GraphQLLogger(Mocks.currentTimeProvider),
    );

    getIt.registerFactory<CurrentTimeProvider>(() => Mocks.currentTimeProvider);

    getIt.registerFactory<GetAuthTokenUseCase>(() => Mocks.getAuthTokenUseCase);
    final environmentConfigProvider = getIt<EnvironmentConfigProvider>();
    when(() => Mocks.environmentConfigProvider.getConfig()).thenAnswer((_) {
      return environmentConfigProvider.getConfig();
    });
    when(() => Mocks.environmentConfigProvider.shouldUseShortLivedAuthTokens()).thenAnswer((_) async => true);
    when(() => Mocks.environmentConfigProvider.getAdditionalGraphQLHeaders()).thenAnswer((_) => Future.value({}));
    when(
      () => Mocks.dioClient.post<dynamic>(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
        onSendProgress: any(named: 'onSendProgress'),
      ),
    ).thenAnswer((invocation) {
      final request = invocation.positionalArguments[0] as String;
      final response = dio.Response<Map<String, dynamic>>(
        data: jsonDecode(testResponse(request)) as Map<String, dynamic>,
        requestOptions: dio.RequestOptions(),
        statusCode: 200,
      );
      return Future.value(response);
    });
    mocking();
  }
}

const testQuery = '''
query {
    testQuery() {
        content
    }
}
''';

String testResponse(dynamic content) => '''
{
  "data": {
    "__typename": "TestQuery",
    "testQuery": {
      "__typename": "TestQuery",
      "content": "$content"   
    } 
  }
}
''';

class TestSessionInvalidatedListenersContainer extends SessionInvalidatedListenersContainer {
  String? _id;

  @override
  String toString() {
    return _id ??= Random().nextInt(999999).toString();
  }
}

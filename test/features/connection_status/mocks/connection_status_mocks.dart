import 'package:mocktail/mocktail.dart';

import 'connection_status_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class ConnectionStatusMocks {
  // MVP

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetConnectionStatusUseCase getConnectionStatusUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockConnectionStatusRepository connectionStatusRepository;
//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getConnectionStatusUseCase = MockGetConnectionStatusUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    connectionStatusRepository = MockConnectionStatusRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetConnectionStatusUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockConnectionStatusRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}

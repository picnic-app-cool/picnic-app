import 'package:mocktail/mocktail.dart';

import 'user_agreement_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class UserAgreementMocks {
  // MVP

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockHasUserAgreedToAppsTermsUseCase hasUserAgreedToAppsTermsUseCase;

  static late MockAcceptAppsTermsUseCase acceptAppsTermsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
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
    hasUserAgreedToAppsTermsUseCase = MockHasUserAgreedToAppsTermsUseCase();

    acceptAppsTermsUseCase = MockAcceptAppsTermsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockHasUserAgreedToAppsTermsUseCase());

    registerFallbackValue(MockAcceptAppsTermsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}

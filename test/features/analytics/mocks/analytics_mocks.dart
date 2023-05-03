import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_event_tap.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';

import 'analytics_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class AnalyticsMocks {
  // MVP

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockLogAnalyticsEventUseCase logAnalyticsEventUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockAnalyticsRepository analyticsRepository;

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
    logAnalyticsEventUseCase = MockLogAnalyticsEventUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    analyticsRepository = MockAnalyticsRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockLogAnalyticsEventUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockAnalyticsRepository());
    registerFallbackValue(const AnalyticsEventTap(target: AnalyticsTapTarget.chatAttachmentButton));
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}

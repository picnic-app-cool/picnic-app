import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockLogAnalyticsEventUseCase extends Mock implements LogAnalyticsEventUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockAnalyticsRepository extends Mock implements AnalyticsRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

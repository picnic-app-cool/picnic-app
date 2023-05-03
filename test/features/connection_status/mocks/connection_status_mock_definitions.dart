import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/connection_status/domain/repositories/connection_status_repository.dart';
import 'package:picnic_app/features/connection_status/domain/use_cases/get_connection_status_use_case.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetConnectionStatusUseCase extends Mock implements GetConnectionStatusUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockConnectionStatusRepository extends Mock implements ConnectionStatusRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

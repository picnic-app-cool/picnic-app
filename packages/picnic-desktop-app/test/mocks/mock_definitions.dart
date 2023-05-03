import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_desktop_app/core/domain/use_cases/enable_launch_at_startup_use_case.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

class MockAppNavigator extends Mock implements AppNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES

class MockEnableLaunchAtStartupUseCase extends Mock implements EnableLaunchAtStartupUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES

//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
class MockUserStore extends MockCubit<PrivateProfile> implements UserStore {}
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

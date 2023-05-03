import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/force_update/domain/model/fetch_app_version_failure.dart';
import 'package:picnic_app/features/force_update/domain/model/open_store_failure.dart';
import 'package:picnic_app/features/force_update/domain/use_case/fetch_min_app_version_use_case.dart';
import 'package:picnic_app/features/force_update/domain/use_case/open_store_use_case.dart';
import 'package:picnic_app/features/force_update/domain/use_case/should_show_force_update_use_case.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';
import 'package:picnic_app/features/force_update/force_update_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockForceUpdatePresenter extends MockCubit<ForceUpdateViewModel> implements ForceUpdatePresenter {}

class MockForceUpdatePresentationModel extends Mock implements ForceUpdatePresentationModel {}

class MockForceUpdateInitialParams extends Mock implements ForceUpdateInitialParams {}

class MockForceUpdateNavigator extends Mock implements ForceUpdateNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION
class MockFetchMinAppVersionUseCase extends Mock implements FetchMinAppVersionUseCase {}

class MockFetchAppVersionFailure extends Mock implements FetchAppVersionFailure {}

class MockShouldShowForceUpdateUseCase extends Mock implements ShouldShowForceUpdateUseCase {}

class MockOpenStoreFailure extends Mock implements OpenStoreFailure {}

class MockOpenStoreUseCase extends Mock implements OpenStoreUseCase {}

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

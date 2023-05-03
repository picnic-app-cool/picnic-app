import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_navigator.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockMainPresenter extends MockCubit<MainViewModel> implements MainPresenter {}

class MockMainPresentationModel extends Mock implements MainPresentationModel {}

class MockMainInitialParams extends Mock implements MainInitialParams {}

class MockMainNavigator extends Mock implements MainNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

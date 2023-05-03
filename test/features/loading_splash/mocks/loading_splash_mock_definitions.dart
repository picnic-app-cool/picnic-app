import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import "package:picnic_app/features/loading_splash/loading_splash_initial_params.dart";
import "package:picnic_app/features/loading_splash/loading_splash_navigator.dart";
import "package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart";
import "package:picnic_app/features/loading_splash/loading_splash_presenter.dart";

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockLoadingSplashPresenter extends MockCubit<LoadingSplashViewModel> implements LoadingSplashPresenter {}

class MockLoadingSplashPresentationModel extends Mock implements LoadingSplashPresentationModel {}

class MockLoadingSplashInitialParams extends Mock implements LoadingSplashInitialParams {}

class MockLoadingSplashNavigator extends Mock implements LoadingSplashNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

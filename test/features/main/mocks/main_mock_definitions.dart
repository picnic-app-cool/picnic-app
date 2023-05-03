import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/main/domain/repositories/language_repository.dart';
import "package:picnic_app/features/main/languages_list/languages_list_initial_params.dart";
import "package:picnic_app/features/main/languages_list/languages_list_navigator.dart";
import "package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart";
import "package:picnic_app/features/main/languages_list/languages_list_presenter.dart";
import "package:picnic_app/features/main/main_initial_params.dart";
import "package:picnic_app/features/main/main_navigator.dart";
import "package:picnic_app/features/main/main_presentation_model.dart";
import "package:picnic_app/features/main/main_presenter.dart";

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockMainPresenter extends MockCubit<MainViewModel> implements MainPresenter {}

class MockMainPresentationModel extends Mock implements MainPresentationModel {}

class MockMainInitialParams extends Mock implements MainInitialParams {}

class MockMainNavigator extends Mock implements MainNavigator {}

class MockLanguagesListPresenter extends MockCubit<LanguagesListViewModel> implements LanguagesListPresenter {}

class MockLanguagesListPresentationModel extends Mock implements LanguagesListPresentationModel {}

class MockLanguagesListInitialParams extends Mock implements LanguagesListInitialParams {}

class MockLanguagesListNavigator extends Mock implements LanguagesListNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockLanguageRepository extends Mock implements LanguageRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

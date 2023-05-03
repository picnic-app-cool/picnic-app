import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_navigator.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presentation_model.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presenter.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockPhotoEditorPresenter extends MockCubit<PhotoEditorViewModel> implements PhotoEditorPresenter {}

class MockPhotoEditorPresentationModel extends Mock implements PhotoEditorPresentationModel {}

class MockPhotoEditorInitialParams extends Mock implements PhotoEditorInitialParams {}

class MockPhotoEditorNavigator extends Mock implements PhotoEditorNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';
import 'package:picnic_app/features/video_editor/video_editor_navigator.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';
import 'package:picnic_app/features/video_editor/video_editor_presenter.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockVideoEditorPresenter extends MockCubit<VideoEditorViewModel> implements VideoEditorPresenter {}

class MockVideoEditorPresentationModel extends Mock implements VideoEditorPresentationModel {}

class MockVideoEditorInitialParams extends Mock implements VideoEditorInitialParams {}

class MockVideoEditorNavigator extends Mock implements VideoEditorNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

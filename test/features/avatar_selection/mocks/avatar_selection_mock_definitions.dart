import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presenter.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockAvatarSelectionPresenter extends MockCubit<AvatarSelectionViewModel> implements AvatarSelectionPresenter {}

class MockAvatarSelectionPresentationModel extends Mock implements AvatarSelectionPresentationModel {}

class MockAvatarSelectionInitialParams extends Mock implements AvatarSelectionInitialParams {}

class MockAvatarSelectionNavigator extends Mock implements AvatarSelectionNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

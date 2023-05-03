import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_navigator.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockMediaPickerPresentationModel extends Mock implements MediaPickerPresentationModel {}

class MockMediaPickerInitialParams extends Mock implements MediaPickerInitialParams {}

class MockImageVideoPickerNavigator extends Mock implements MediaPickerNavigator {}

class MockMediaPickerMediator extends Mock implements MediaPickerMediator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

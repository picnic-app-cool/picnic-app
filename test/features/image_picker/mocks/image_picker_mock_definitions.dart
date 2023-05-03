import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_presenter.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockImagePickerPresenter extends MockCubit<ImagePickerViewModel> implements ImagePickerPresenter {}

class MockImagePickerPresentationModel extends Mock implements ImagePickerPresentationModel {}

class MockImagePickerInitialParams extends Mock implements ImagePickerInitialParams {}

class MockImagePickerNavigator extends Mock implements ImagePickerNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

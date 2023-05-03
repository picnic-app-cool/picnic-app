import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/image_picker/image_picker_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_presenter.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';

import '../../../../../../test/mocks/mocks.dart';
import '../mocks/image_picker_mock_definitions.dart';

void main() {
  late ImagePickerPresentationModel model;
  late ImagePickerPresenter presenter;
  late MockImagePickerNavigator navigator;

  test(
    'there should be only gallery option when platform is desktop',
    () {
      expect(
        presenter.state.availableOptions,
        [ImageSourceType.gallery],
      );
    },
  );

  setUp(() {
    when(() => Mocks.devicePlatformProvider.currentPlatform).thenReturn(DevicePlatform.macos);
    model = ImagePickerPresentationModel.initial(
      const ImagePickerInitialParams(),
      Mocks.devicePlatformProvider,
    );
    navigator = MockImagePickerNavigator();
    presenter = ImagePickerPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.getRuntimePermissionStatusUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.appInfoStore,
    );
  });
}

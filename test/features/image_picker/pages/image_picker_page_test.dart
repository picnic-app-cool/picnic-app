import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_page.dart';
import 'package:picnic_app/features/image_picker/image_picker_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late ImagePickerPage page;
  late ImagePickerInitialParams initParams;
  late ImagePickerPresentationModel model;
  late ImagePickerPresenter presenter;
  late ImagePickerNavigator navigator;

  void _initMvp() {
    when(() => Mocks.devicePlatformProvider.currentPlatform).thenReturn(DevicePlatform.ios);
    initParams = const ImagePickerInitialParams();
    model = ImagePickerPresentationModel.initial(
      initParams,
      Mocks.devicePlatformProvider,
    );
    navigator = ImagePickerNavigator(Mocks.appNavigator);
    presenter = ImagePickerPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.getRuntimePermissionStatusUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.appInfoStore,
    );
    page = ImagePickerPage(presenter: presenter);
  }

  await screenshotTest(
    "image_picker_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ImagePickerPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

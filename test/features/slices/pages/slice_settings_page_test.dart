import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_bottom_sheet_page.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_navigator.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late SliceSettingsBottomSheetPage page;
  late SliceSettingsInitialParams initParams;
  late SliceSettingsPresentationModel model;
  late SliceSettingsPresenter presenter;
  late SliceSettingsNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 10, 26));
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(
      () => Mocks.slicesRepository.joinSlice(sliceId: any(named: 'sliceId')),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
    initParams = SliceSettingsInitialParams(circle: Stubs.circle, slice: Stubs.slice);
    model = SliceSettingsPresentationModel.initial(
      initParams,
    );
    navigator = SliceSettingsNavigator(Mocks.appNavigator);

    presenter = SliceSettingsPresenter(
      model,
      navigator,
      Mocks.joinSliceUseCase,
      Mocks.leaveSliceUseCase,
    );
    page = SliceSettingsBottomSheetPage(presenter: presenter);
  }

  await screenshotTest(
    "slice_settings_bottom_sheet_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SliceSettingsBottomSheetPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

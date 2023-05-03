import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/force_update/force_update_page.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';
import 'package:picnic_app/features/force_update/force_update_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/force_update_mocks.dart';

Future<void> main() async {
  late ForceUpdatePage page;
  late ForceUpdateInitialParams initParams;
  late ForceUpdatePresentationModel model;
  late ForceUpdatePresenter presenter;
  late ForceUpdateNavigator navigator;

  void initMvp() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
    when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(true));
    when(() => ForceUpdateMocks.openStoreUseCase.execute(Stubs.appInfo.packageName))
        .thenAnswer((_) => successFuture(unit));

    initParams = const ForceUpdateInitialParams();
    model = ForceUpdatePresentationModel.initial(
      initParams,
      Mocks.appInfoStore,
    );
    navigator = ForceUpdateNavigator(Mocks.appNavigator);
    presenter = ForceUpdatePresenter(
      model,
      navigator,
      ForceUpdateMocks.openStoreUseCase,
    );
    page = ForceUpdatePage(presenter: presenter);
  }

  await screenshotTest(
    "force_update_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<ForceUpdatePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

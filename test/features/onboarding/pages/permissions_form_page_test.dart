import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_navigator.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_page.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late PermissionsFormPage page;
  late PermissionsFormInitialParams initParams;
  late PermissionsFormPresentationModel model;
  late PermissionsFormPresenter presenter;
  late PermissionsFormNavigator navigator;

  void _initMvp() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
    when(() => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.notifications)) //
        .thenAnswer((_) => successFuture(RuntimePermissionStatus.denied));
    when(() => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.contacts)) //
        .thenAnswer((_) => successFuture(RuntimePermissionStatus.denied));

    initParams = PermissionsFormInitialParams(onContinue: (_) {});
    model = PermissionsFormPresentationModel.initial(
      initParams,
      Mocks.appInfoStore,
    );
    navigator = PermissionsFormNavigator(Mocks.appNavigator);
    presenter = PermissionsFormPresenter(
      model,
      navigator,
      Mocks.getRuntimePermissionStatusUseCase,
      Mocks.requestRuntimePermissionUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = PermissionsFormPage(presenter: presenter);
  }

  await screenshotTest(
    "Permissions_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PermissionsFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

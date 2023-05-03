import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_navigator.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_page.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late AfterPostDialogPage page;
  late AfterPostDialogInitialParams initParams;
  late AfterPostDialogPresentationModel model;
  late AfterPostDialogPresenter presenter;
  late AfterPostDialogNavigator navigator;

  void initMvp({
    RuntimePermissionStatus runtimePermissionStatus = RuntimePermissionStatus.granted,
  }) {
    initParams = AfterPostDialogInitialParams(post: Stubs.imagePost);
    model = AfterPostDialogPresentationModel.initial(
      initParams,
    );
    navigator = AfterPostDialogNavigator(Mocks.appNavigator);

    presenter = AfterPostDialogPresenter(
      model,
      navigator,
      Mocks.getContactsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.uploadContactsUseCase,
      Mocks.getPhoneContactsUseCase,
      Mocks.debouncer,
      Mocks.sharePostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    when(
      () => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts),
    ).thenAnswer((invocation) => successFuture(runtimePermissionStatus));
    when(
      () => Mocks.uploadContactsUseCase.execute(),
    ).thenAnswer((invocation) => successFuture(unit));
    when(
      () => Mocks.getContactsUseCase.execute(
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (_) => successFuture(
        Stubs.userContacts,
      ),
    );
    when(
      () => Mocks.getPhoneContactsUseCase.execute(),
    ).thenAnswer(
      (_) => Future.value(Stubs.phoneContacts),
    );
    page = AfterPostDialogPage(presenter: presenter);
  }

  await screenshotTest(
    "after_post_dialog_page",
    variantName: "contact_permission_granted",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "after_post_dialog_page",
    variantName: "contact_permission_denied",
    setUp: () async {
      initMvp(runtimePermissionStatus: RuntimePermissionStatus.denied);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<AfterPostDialogPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

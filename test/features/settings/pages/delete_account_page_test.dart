import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_navigator.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_page.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

Future<void> main() async {
  late DeleteAccountPage page;
  late DeleteAccountInitialParams initParams;
  late DeleteAccountPresentationModel model;
  late DeleteAccountPresenter presenter;
  late DeleteAccountNavigator navigator;

  void _initMvp() {
    initParams = const DeleteAccountInitialParams();
    model = DeleteAccountPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 12, 9, 12, 32, 54));
    navigator = DeleteAccountNavigator(Mocks.appNavigator);
    presenter = DeleteAccountPresenter(
      model,
      navigator,
      SettingsMocks.requestDeleteAccountUseCase,
      Mocks.logOutUseCase,
      SettingsMocks.getDeleteAccountReasonsUseCase,
    );
    page = DeleteAccountPage(presenter: presenter);

    when(
      () => SettingsMocks.getDeleteAccountReasonsUseCase.execute(
        documentEntityType: DocumentEntityType.deleteAccount,
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.deleteAccountReasons),
    );
  }

  await screenshotTest(
    "delete_account_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<DeleteAccountPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

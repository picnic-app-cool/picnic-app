import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_navigator.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_page.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late DeleteAccountReasonsPage page;
  late DeleteAccountReasonsInitialParams initParams;
  late DeleteAccountReasonsPresentationModel model;
  late DeleteAccountReasonsPresenter presenter;
  late DeleteAccountReasonsNavigator navigator;

  void _initMvp() {
    initParams = DeleteAccountReasonsInitialParams(
      reasons: Stubs.deleteAccountReasons,
    );
    model = DeleteAccountReasonsPresentationModel.initial(
      initParams,
    );
    navigator = DeleteAccountReasonsNavigator(Mocks.appNavigator);
    presenter = DeleteAccountReasonsPresenter(
      model,
      navigator,
    );
    page = DeleteAccountReasonsPage(presenter: presenter);
  }

  await screenshotTest(
    "delete_account_reasons_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<DeleteAccountReasonsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_page.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late AboutElectionsPage page;
  late AboutElectionsInitialParams initParams;
  late AboutElectionsPresentationModel model;
  late AboutElectionsPresenter presenter;
  late AboutElectionsNavigator navigator;

  void initMvp({Circle? circle}) {
    initParams = AboutElectionsInitialParams(circle: circle);
    model = AboutElectionsPresentationModel.initial(
      initParams,
    );
    navigator = AboutElectionsNavigator(Mocks.appNavigator);
    presenter = AboutElectionsPresenter(
      model,
      navigator,
    );
    page = AboutElectionsPage(presenter: presenter);
  }

  await screenshotTest(
    "about_elections_page_with_confirm_button",
    setUp: () async {
      initMvp(circle: Stubs.circle);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "about_elections_page_with_back_button",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<AboutElectionsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_navigator.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_page.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late GetVerifiedPage page;
  late GetVerifiedInitialParams initParams;
  late GetVerifiedPresentationModel model;
  late GetVerifiedPresenter presenter;
  late GetVerifiedNavigator navigator;

  void _initMvp() {
    initParams = const GetVerifiedInitialParams();
    model = GetVerifiedPresentationModel.initial(
      initParams,
    );
    navigator = GetVerifiedNavigator(Mocks.appNavigator);
    presenter = GetVerifiedPresenter(
      model,
      navigator,
    );
    page = GetVerifiedPage(presenter: presenter);
  }

  await screenshotTest(
    "get_verified_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<GetVerifiedPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

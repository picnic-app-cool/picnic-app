import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_navigator.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_page.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late AddBlackListWordPage page;
  late AddBlackListWordInitialParams initParams;
  late AddBlackListWordPresentationModel model;
  late AddBlackListWordPresenter presenter;
  late AddBlackListWordNavigator navigator;

  void _initMvp() {
    initParams = AddBlackListWordInitialParams(circleId: Stubs.id);
    model = AddBlackListWordPresentationModel.initial(
      initParams,
    );
    navigator = AddBlackListWordNavigator(Mocks.appNavigator);
    presenter = AddBlackListWordPresenter(
      model,
      navigator,
      CirclesMocks.addBlacklistedWordsUseCase,
      CirclesMocks.removeBlacklistedWordsUseCase,
    );
    page = AddBlackListWordPage(presenter: presenter);
  }

  await screenshotTest(
    "add_black_list_word_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<AddBlackListWordPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

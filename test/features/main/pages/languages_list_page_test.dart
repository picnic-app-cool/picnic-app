import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_initial_params.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_navigator.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_page.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late LanguagesListPage page;
  late LanguagesListInitialParams initParams;
  late LanguagesListPresentationModel model;
  late LanguagesListPresenter presenter;
  late LanguagesListNavigator navigator;

  void _initMvp() {
    initParams = const LanguagesListInitialParams(selectedLanguage: Language.empty());
    model = LanguagesListPresentationModel.initial(
      initParams,
    );
    navigator = LanguagesListNavigator(Mocks.appNavigator);
    presenter = LanguagesListPresenter(
      model,
      navigator,
      Mocks.getLanguagesListUseCase,
    );
    page = LanguagesListPage(presenter: presenter);
    when(() => Mocks.getLanguagesListUseCase.execute()).thenAnswer((_) => successFuture(Stubs.languages));
  }

  await screenshotTest(
    "languages_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<LanguagesListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_desktop_app/dependency_injection/app_component.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_navigator.dart';
import 'package:picnic_desktop_app/features/main/main_page.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  // ignore: unused_local_variable
  late MainPage page;
  late MainInitialParams initParams;
  late MainPresentationModel model;
  late MainPresenter presenter;
  late MainNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = const MainInitialParams();
    model = MainPresentationModel.initial(initParams, Mocks.userStore);
    navigator = MainNavigator(Mocks.appNavigator);
    presenter = MainPresenter(
      model,
      navigator,
    );
    page = MainPage(presenter: presenter);
  }

  await screenshotTest(
    'main_page',
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => const Center(
      child: Text(
        'Sample test',
      ),
    ),
    // TODO Should be fixed after isolate a separated package packages/pinic-ui-components https://picnic-app.atlassian.net/browse/GS-5257
    //pageBuilder: () => page,
  );

  test('getIt page resolves successfully', () async {
    initMvp();
    final page = getIt<MainPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

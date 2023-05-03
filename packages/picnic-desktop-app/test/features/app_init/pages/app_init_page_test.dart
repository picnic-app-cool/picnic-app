import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_desktop_app/dependency_injection/app_component.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_initial_params.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_navigator.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_page.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presenter.dart';
import '../../../../../../test/features/app_init/mocks/app_init_mocks.dart' as picnic_app;
import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/app_init_mock_definitions.dart';

// TODO fix screenshot tests https://picnic-app.atlassian.net/browse/GS-5845
Future<void> main() async {
  late AppInitPage page;
  late AppInitInitialParams initParams;
  late AppInitPresentationModel model;
  late AppInitPresenter presenter;
  late AppInitNavigator navigator;

  void initMvp() {
    initParams = const AppInitInitialParams();
    model = AppInitPresentationModel.initial(
      initParams,
    );
    navigator = MockAppInitNavigator();
    presenter = AppInitPresenter(
      model,
      navigator,
      picnic_app.AppInitMocks.appInitUseCase,
      Mocks.userStore,
      Mocks.enableLaunchAtStartupUseCase,
    );
    page = AppInitPage(presenter: presenter);
  }

  await screenshotTest(
    'app_init_page',
    setUp: () async {
      initMvp();
      when(() => picnic_app.AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => Mocks.enableLaunchAtStartupUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
    },
    pageBuilder: () => page,
  );

  test('getIt page resolves successfully', () async {
    initMvp();
    final page = getIt<AppInitPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

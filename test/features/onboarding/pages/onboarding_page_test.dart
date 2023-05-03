import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_page.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late OnboardingPage page;
  late OnboardingInitialParams initParams;
  late OnboardingPresentationModel model;
  late OnboardingPresenter presenter;
  late OnboardingNavigator navigator;

  void _initMvp() {
    final key = OnboardingNavigatorKey();
    initParams = const OnboardingInitialParams();
    model = OnboardingPresentationModel.initial(
      initParams,
    );
    navigator = OnboardingNavigator(Mocks.appNavigator, key);
    presenter = OnboardingPresenter(
      model,
      navigator,
      OnboardingMocks.registerUseCase,
      Mocks.getRuntimePermissionStatusUseCase,
      ProfileMocks.editProfileUseCase,
      Mocks.userStore,
    );
    when(
      () => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.notifications),
    ).thenAnswer(
      (_) => successFuture(RuntimePermissionStatus.denied),
    );
    when(
      () => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.contacts),
    ).thenAnswer(
      (_) => successFuture(RuntimePermissionStatus.denied),
    );

    page = OnboardingPage(presenter: presenter, navigatorKey: key);
  }

  await screenshotTest(
    "onboarding_page",
    // we're using globalKey inside onboardingPage thus we can't
    // really render two pages at the same time, hence we render only one
    devices: [testDevices.last],
    setUp: () async {
      when(
        () => Mocks.appNavigator.pushReplacement<void>(
          any(),
          context: any(named: "context"),
          useRoot: any(named: "useRoot"),
        ),
      ) //
          .thenAnswer((invocation) => Future.value());
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    getIt.registerFactory(() => OnboardingNavigatorKey());
    final page = getIt<OnboardingPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

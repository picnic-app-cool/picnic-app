import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_page.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presenter.dart';
import 'package:picnic_app/resources/assets.gen.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late BanUserPage page;
  late BanUserInitialParams initParams;
  late BanUserPresentationModel model;
  late BanUserPresenter presenter;
  late BanUserNavigator navigator;

  void _initMvp() {
    initParams = BanUserInitialParams(
      user: const PublicProfile.empty().copyWith(
        user: const User.empty().copyWith(
          profileImageUrl: ImageUrl(Assets.images.rocket.path),
        ),
      ),
      circleId: Stubs.circle.id,
    );
    model = BanUserPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = BanUserNavigator(Mocks.appNavigator);
    presenter = BanUserPresenter(
      model,
      CirclesMocks.banUserUseCase,
      navigator,
    );
    page = BanUserPage(presenter: presenter);
  }

  await screenshotTest(
    "ban_user_page",
    variantName: "temp_ban_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "ban_user_page",
    variantName: "temp_ban_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    _initMvp();
    final page = getIt<BanUserPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

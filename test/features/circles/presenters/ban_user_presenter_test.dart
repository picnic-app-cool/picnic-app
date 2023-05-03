import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presenter.dart';
import 'package:picnic_app/resources/assets.gen.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late BanUserPresentationModel model;
  late BanUserPresenter presenter;
  late MockBanUserNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    model = BanUserPresentationModel.initial(
      BanUserInitialParams(
        user: const PublicProfile.empty().copyWith(
          user: const User.empty().copyWith(profileImageUrl: ImageUrl(Assets.images.rocket.path)),
        ),
        circleId: Stubs.circle.id,
      ),
      Mocks.featureFlagsStore,
    );
    navigator = MockBanUserNavigator();
    presenter = BanUserPresenter(
      model,
      CirclesMocks.banUserUseCase,
      navigator,
    );
  });
}

import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presenter.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleMemberSettingsPresentationModel model;
  late CircleMemberSettingsPresenter presenter;
  late MockCircleMemberSettingsNavigator navigator;

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    model = CircleMemberSettingsPresentationModel.initial(
      CircleMemberSettingsInitialParams(
        user: Stubs.publicProfile,
        circle: Stubs.circle,
      ),
      Mocks.userStore,
    );
    navigator = MockCircleMemberSettingsNavigator();

    when(() => Mocks.getUserUseCase.execute(userId: Stubs.user.id))
        .thenAnswer((invocation) => successFuture(const PublicProfile.empty()));

    when(() => ProfileMocks.getProfileStatsUseCase.execute(userId: Stubs.user.id))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    when(() => Mocks.followUserUseCase.execute(userId: Stubs.user.id, follow: true))
        .thenAnswer((invocation) => successFuture(unit));

    presenter = CircleMemberSettingsPresenter(
      model,
      navigator,
      ChatMocks.createSingleChatUseCase,
      Mocks.followUserUseCase,
      const GetUserActionUseCase(),
      Mocks.sendGlitterBombUseCase,
      Mocks.getUserUseCase,
      ProfileMocks.getProfileStatsUseCase,
      Mocks.unblockUserUseCase,
      CirclesMocks.getUserRolesInCircleUseCase,
    );
  });

  test('tapping close should close the navigator', () {
    //WHEN
    presenter.onTapClose();

    //THEN
    verify(() => navigator.closeWithResult(false)).called(1);
  });

  test(
    'tapping on dm should open SingleChatPage',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")))
            .thenAnswer((_) => successFuture(Stubs.basicChat));

        when(() => navigator.openSingleChat(any())).thenAnswer((_) {
          return Future.value();
        });

        // WHEN
        presenter.onTapDm();
        async.flushMicrotasks();

        // THEN
        verify(() => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")));
        verify(() => navigator.openSingleChat(any()));
      });
    },
  );
}

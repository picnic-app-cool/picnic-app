import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_single_chat_use_case.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_user_roles_in_circle_use_case.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';

class CircleMemberSettingsPresenter extends Cubit<CircleMemberSettingsViewModel> {
  CircleMemberSettingsPresenter(
    CircleMemberSettingsViewModel model,
    this.navigator,
    this._createSingleChatUseCase,
    this._followUnfollowUserUseCase,
    this._getUserActionUseCase,
    this._sendGlitterBombUseCase,
    this._getUserUseCase,
    this._getProfileStatsUseCase,
    this._unblockUserUseCase,
    this._getRolesForUserUseCase,
  ) : super(model);

  final CircleMemberSettingsNavigator navigator;
  final CreateSingleChatUseCase _createSingleChatUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUserUseCase;
  final GetUserActionUseCase _getUserActionUseCase;
  final SendGlitterBombUseCase _sendGlitterBombUseCase;
  final UnblockUserUseCase _unblockUserUseCase;

  final GetUserUseCase _getUserUseCase;
  final GetProfileStatsUseCase _getProfileStatsUseCase;
  final GetUserRolesInCircleUseCase _getRolesForUserUseCase;

  // ignore: unused_element
  CircleMemberSettingsPresentationModel get _model => state as CircleMemberSettingsPresentationModel;

  Future<void> onInit() async {
    _getUser();
    _getProfileStats();
    _getUserRoles();
  }

  void onTapStatType(StatType type) => doNothing();

  void onTapAction(PublicProfileAction profileAction) {
    switch (profileAction) {
      case PublicProfileAction.follow:
      case PublicProfileAction.following:
        _toggleFollow();
        break;
      case PublicProfileAction.glitterbomb:
        _onTapGlitterBomb();
        break;
      case PublicProfileAction.blocked:
        _onTapUnBlock();
        break;
    }
  }

  Future<void> onTapEditRoles() async {
    onTapClose();
    await navigator.openUserRoles(
      UserRolesInitialParams(
        user: _model.publicProfile,
        circleId: _model.circle.id,
      ),
    );
    _getUserRoles();
  }

  void onTapClose() => navigator.closeWithResult(false);

  Future<void> onTapDm() async {
    await _createSingleChatUseCase
        .execute(
          userIds: _model.singleChatUserIds,
        )
        .doOn(
          fail: (failure) => navigator.showError(
            failure.displayableFailure(),
          ),
          success: _openSingleChat,
        );
  }

  void onTapProfile() => navigator.openProfile(userId: _model.publicProfile.id);

  Future<void> _toggleFollow() async {
    final previousFollowState = _model.publicProfile.iFollow;

    final counter = previousFollowState ? -1 : 1;

    final followersCount = _model.profileStats.followers;
    final profile = _model.publicProfile.copyWith(iFollow: !previousFollowState);

    final profileStats = _model.profileStats.copyWith(followers: followersCount + counter);
    tryEmit(
      _model
          .byUpdatingPublicProfile(publicProfile: profile)
          .copyWith(action: _getUserActionUseCase.execute(profile))
          .byUpdatingProfileStats(profileStats: profileStats),
    );
    await _followUnfollowUserUseCase.execute(userId: _model.publicProfile.id, follow: !previousFollowState).doOn(
      fail: (error) {
        tryEmit(
          _model.byUpdatingPublicProfile(publicProfile: _model.publicProfile.copyWith(iFollow: previousFollowState)),
        );

        navigator.showError(error.displayableFailure());
      },
    ).observeStatusChanges((result) => tryEmit(_model.copyWith(followResult: result)));
  }

  void _onTapGlitterBomb() => _sendGlitterBombUseCase.execute(_model.publicProfile.id).doOn(
        success: (_) => navigator
          ..showFxEffect(LottieFxEffect.glitter())
          ..showFxEffect(ConfettiFxEffect.avatar(_model.privateProfile.profileImageUrl)),
      );

  void _onTapUnBlock() => _unblockUserUseCase
      .execute(
        userId: _model.publicProfile.id,
      ) //
      .doOn(
        success: (success) {
          final profile = _model.publicProfile.copyWith(
            isBlocked: false,
            iFollow: false,
          );
          return tryEmit(
            _model.byUpdatingPublicProfile(publicProfile: profile).copyWith(
                  action: _getUserActionUseCase.execute(
                    profile,
                  ),
                ),
          );
        },
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  void _openSingleChat(BasicChat chat) {
    navigator.openSingleChat(
      SingleChatInitialParams(chat: chat),
    );
  }

  void _getProfileStats() => _getProfileStatsUseCase
      .execute(userId: _model.publicProfile.id)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(profileStatsResult: result)),
      )
      .doOn(
        success: (profileStats) => tryEmit(_model.copyWith(profileStats: profileStats)),
        //intentionally not showing any error, since users cannot recover from it anyway
        fail: (fail) => tryEmit(_model.copyWith(profileStats: const ProfileStats.empty())),
      );

  void _getUser() => _getUserUseCase
      .execute(userId: _model.publicProfile.id) //
      .observeStatusChanges(
        (userResult) => tryEmit(_model.copyWith(userResult: userResult)),
      )
      .doOn(
        success: (profile) =>
            tryEmit(_model.copyWith(action: _getUserActionUseCase.execute(profile), publicProfile: profile)),
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  void _getUserRoles() {
    _getRolesForUserUseCase
        .execute(
          circleId: _model.circle.id,
          userId: _model.user.id,
        )
        .doOn(
          success: (userRoles) {
            tryEmit(
              _model.copyWith(
                roles: userRoles.roles,
              ),
            );
          },
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }
}

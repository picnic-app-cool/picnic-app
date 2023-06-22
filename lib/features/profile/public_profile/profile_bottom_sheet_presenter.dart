import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_single_chat_use_case.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class ProfileBottomSheetPresenter extends Cubit<ProfileBottomSheetViewModel> {
  ProfileBottomSheetPresenter(
    super.model,
    this.navigator,
    this._getUserUseCase,
    this._followUnfollowUserUseCase,
    this._getUserActionUseCase,
    this._sendGlitterBombUseCase,
    this._createSingleChatUseCase,
    this._getProfileStatsUseCase,
    this._logAnalyticsEventUseCase,
    this._clipboardManager,
  );

  final ProfileBottomSheetNavigator navigator;
  final GetUserUseCase _getUserUseCase;

  final SendGlitterBombUseCase _sendGlitterBombUseCase;
  final CreateSingleChatUseCase _createSingleChatUseCase;

  final FollowUnfollowUserUseCase _followUnfollowUserUseCase;

  final GetUserActionUseCase _getUserActionUseCase;
  final GetProfileStatsUseCase _getProfileStatsUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final ClipboardManager _clipboardManager;

  // ignore: unused_element
  ProfileBottomSheetPresentationModel get _model => state as ProfileBottomSheetPresentationModel;

  Future<void> onInit() async {
    _getUser();
    _getProfileStats();
  }

  Future<void> openLink(String link) async => navigator.openWebView(link);

  Future<void> onTapCopyUserName() async {
    await _clipboardManager.saveText(_model.publicProfile.username);
    await navigator.showSnackBar(appLocalizations.usernameCopiedAction);
  }

  Future<void> onTapDm() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileDmButton,
      ),
    );

    await _createSingleChatUseCase.execute(userIds: _model.singleChatUserIds).doOn(
          fail: (failure) => navigator.showError(
            failure.displayableFailure(),
          ),
          success: _openSingleChat,
        );
  }

  void onTapStat(StatType type) {
    switch (type) {
      case StatType.followers:
        _onTapFollowers();
        break;
      case StatType.views:
      case StatType.likes:
      case StatType.posts:
      case StatType.slices:
      case StatType.members:
      case StatType.none:
        break;
    }
  }

  void onTapAction(PublicProfileAction profileAction) {
    switch (profileAction) {
      case PublicProfileAction.follow:
      case PublicProfileAction.following:
        toggleFollow();
        break;
      case PublicProfileAction.glitterbomb:
        onTapGlitterBomb();
        break;
      case PublicProfileAction.blocked:
        break;
    }
  }

  Future<void> toggleFollow() async {
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

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileFollowButton,
        targetValue: (!previousFollowState).toString(),
      ),
    );
  }

  void onTapGlitterBomb() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileGlitterbombButton,
      ),
    );

    _sendGlitterBombUseCase.execute(_model.userId).doOn(
          success: (_) => navigator
            ..showFxEffect(LottieFxEffect.glitter())
            ..showFxEffect(ConfettiFxEffect.avatar(_model.privateProfile.profileImageUrl)),
        );
  }

  void onTapViewProfile() => navigator.openPublicProfile(
        PublicProfileInitialParams(
          userId: _model.publicProfile.id,
        ),
      );

  void _getUser() => _getUserUseCase
      .execute(userId: _model.userId) //
      .observeStatusChanges(
        (userResult) => tryEmit(_model.copyWith(userResult: userResult)),
      )
      .doOn(
        success: (profile) =>
            tryEmit(_model.copyWith(action: _getUserActionUseCase.execute(profile), publicProfile: profile)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void _getProfileStats() => _getProfileStatsUseCase
      .execute(userId: _model.userId)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(profileStatsResult: result)),
      )
      .doOn(
        success: (profileStats) => tryEmit(_model.copyWith(profileStats: profileStats)),
        //intentionally not showing any error, since users cannot recover from it any way
        fail: (fail) => tryEmit(_model.copyWith(profileStats: const ProfileStats.empty())),
      );

  void _openSingleChat(BasicChat chat) {
    navigator.openSingleChat(
      SingleChatInitialParams(chat: chat),
    );
  }

  void _onTapFollowers() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileFollowersTap,
      ),
    );

    navigator.openFollowers(FollowersInitialParams(userId: _model.publicProfile.id));
  }
}

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class SingleChatSettingsPresenter extends Cubit<SingleChatSettingsViewModel> {
  SingleChatSettingsPresenter(
    super.model,
    this.navigator,
    this._followUnfollowUserUseCase,
    this._chatSettingsUseCase,
    this._getUserUseCase,
    this._getChatSettingsUseCase,
    this._sendGlitterBombUseCase,
    this._logAnalyticsEventUseCase,
  );

  final SingleChatSettingsNavigator navigator;
  final FollowUnfollowUserUseCase _followUnfollowUserUseCase;
  final UpdateChatSettingsUseCase _chatSettingsUseCase;
  final GetUserUseCase _getUserUseCase;
  final GetChatSettingsUseCase _getChatSettingsUseCase;
  final SendGlitterBombUseCase _sendGlitterBombUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  SingleChatSettingsPresentationModel get _model => state as SingleChatSettingsPresentationModel;

  Future<void> init() {
    return Future.wait([
      _getUserUseCase
          .execute(userId: _model.user.id)
          .doOn(
            success: (user) => tryEmit(_model.copyWith(followed: user.iFollow, followMe: user.followsMe)),
            fail: (failure) => navigator.showError(failure.displayableFailure()),
          )
          .observeStatusChanges((result) => tryEmit(_model.copyWith(getUserResult: result))),
      _getChatSettingsUseCase
          .execute(chatId: _model.chatId)
          .doOn(
            success: (settings) => tryEmit(_model.copyWith(muted: settings.isMuted)),
            fail: (failure) => navigator.showError(failure.displayableFailure()),
          )
          .observeStatusChanges((result) => tryEmit(_model.copyWith(getChatSettingsResult: result))),
    ]);
  }

  void onTapUser() => navigator.openPublicProfile(
        PublicProfileInitialParams(userId: _model.user.id),
      );

  Future<void> onTapActionButton(SingleChatSettingsActions action) {
    switch (action) {
      case SingleChatSettingsActions.report:
        return _report();
      case SingleChatSettingsActions.follow:
        return _followOrUnfollow();
      case SingleChatSettingsActions.mute:
        return _muteOrUnmute();
      case SingleChatSettingsActions.glitterbomb:
        return _sendGlitterBomb();
    }
  }

  Future<void> _followOrUnfollow() async {
    final previousFollowState = _model.followed;
    tryEmit(_model.copyWith(followed: !previousFollowState));
    await _followUnfollowUserUseCase.execute(userId: _model.user.id, follow: !previousFollowState).doOn(
      fail: (error) {
        tryEmit(_model.copyWith(followed: previousFollowState));
        navigator.showError(error.displayableFailure());
      },
    ).observeStatusChanges((result) => tryEmit(_model.copyWith(followResult: result)));
  }

  Future<void> _report() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsReportButton,
      ),
    );
    return navigator.openReportForm(
      ReportFormInitialParams(
        entityId: _model.chatId,
        reportEntityType: ReportEntityType.chat,
      ),
    );
  }

  Future<void> _muteOrUnmute() async {
    if (_model.muted) {
      _logAnalyticsEventUseCase.execute(
        AnalyticsEvent.tap(
          target: AnalyticsTapTarget.chatSettingsUnmuteButton,
        ),
      );
    } else {
      _logAnalyticsEventUseCase.execute(
        AnalyticsEvent.tap(
          target: AnalyticsTapTarget.chatSettingsMuteButton,
        ),
      );
    }
    final previousMuteState = _model.muted;
    tryEmit(_model.copyWith(muted: !previousMuteState));
    await _chatSettingsUseCase
        .execute(chatId: _model.chatId, chatSettings: ChatSettings(isMuted: !previousMuteState))
        .doOn(
      fail: (error) {
        tryEmit(_model.copyWith(muted: previousMuteState));
        navigator.showError(error.displayableFailure());
      },
    ).observeStatusChanges((result) => tryEmit(_model.copyWith(followResult: result)));
  }

  Future<void> _sendGlitterBomb() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsGlitterbombButton,
      ),
    );
    return _sendGlitterBombUseCase.execute(_model.user.id).doOn(
          success: (_) => navigator
            ..showFxEffect(LottieFxEffect.glitter())
            ..showFxEffect(
              ConfettiFxEffect.avatar(_model.user.profileImageUrl),
            ),
        );
  }
}

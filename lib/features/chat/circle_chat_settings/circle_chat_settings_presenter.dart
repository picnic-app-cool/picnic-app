import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presentation_model.dart';
import 'package:picnic_app/features/chat/domain/model/circle_chat_settings_page_result.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_settings_use_case.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class CircleChatSettingsPresenter extends Cubit<CircleChatSettingsViewModel> {
  CircleChatSettingsPresenter(
    super.model,
    this.navigator,
    this._leaveCircleUseCase,
    this._getChatSettingsUseCase,
    this._updateChatSettingsUseCase,
    this._joinCircleUseCase,
    this._logAnalyticsEventUseCase,
  );

  final CircleChatSettingsNavigator navigator;
  final LeaveCircleUseCase _leaveCircleUseCase;
  final GetChatSettingsUseCase _getChatSettingsUseCase;
  final UpdateChatSettingsUseCase _updateChatSettingsUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  CircleChatSettingsPresentationModel get _model => state as CircleChatSettingsPresentationModel;

  void onInit() => _getChatSettings();

  void onTapShare() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsShareButton,
      ),
    );
    navigator.close();
    navigator.shareText(text: _model.circle.inviteCircleLink);
  }

  Future<void> onTapReport() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsReportButton,
      ),
    );
    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            entityId: _model.circle.chat.id,
            reportEntityType: ReportEntityType.chat,
          ),
        ) ??
        false;
    if (reportSuccessful) {
      navigator.close();
    }
  }

  void onTapMute() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsMuteButton,
      ),
    );
    _updateIsMuted(true);
  }

  void onTapUnMute() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsUnmuteButton,
      ),
    );
    _updateIsMuted(false);
  }

  void onTapLeave() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsLeaveButton,
      ),
    );
    _leaveCircleUseCase.execute(circle: _model.circle.toBasicCircle()).doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (_) => navigator.closeWithResult(CircleChatSettingsPageResult.didLeftCircle),
        );
  }

  void onTapSeeFeed() {
    notImplemented();
  }

  void onTapCirclePage() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsCircleTap,
      ),
    );
    navigator.openCircleDetails(
      CircleDetailsInitialParams(
        circleId: _model.circle.id,
      ),
    );
  }

  void onTapClose() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsCloseButton,
      ),
    );
    navigator.close();
  }

  void onTapJoinCircle() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsJoinButton,
      ),
    );
    _joinCircleUseCase.execute(circle: _model.circle.toBasicCircle()).doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (_) {
            tryEmit(
              _model.byUpdatingCircle(
                _model.circle.copyWith(
                  iJoined: true,
                  membersCount: _model.circle.membersCount + 1,
                ),
              ),
            );
          },
        );
  }

  void _getChatSettings() => _getChatSettingsUseCase
      .execute(
        chatId: _model.circle.chat.id,
      )
      .doOn(
        success: (result) => tryEmit(
          _model.copyWith(
            chatSettings: result,
          ),
        ),
      );

  void _updateIsMuted(bool isMuted) {
    final newChatSettings = _model.chatSettings.copyWith(
      isMuted: isMuted,
    );
    _updateChatSettingsUseCase
        .execute(
          chatId: _model.circle.chat.id,
          chatSettings: newChatSettings,
        )
        .doOn(
          success: (_) => tryEmit(
            _model.copyWith(
              chatSettings: newChatSettings,
            ),
          ),
        );
  }
}

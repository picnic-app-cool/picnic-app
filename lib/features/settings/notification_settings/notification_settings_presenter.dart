import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/settings/domain/model/notification_item.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_notification_settings_use_case.dart';
import 'package:picnic_app/features/settings/domain/use_cases/update_notification_settings_use_case.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_navigator.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';

class NotificationSettingsPresenter extends Cubit<NotificationSettingsViewModel> {
  NotificationSettingsPresenter(
    NotificationSettingsPresentationModel model,
    this.navigator,
    this._getNotificationSettingsUseCase,
    this._updateNotificationSettingsUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final NotificationSettingsNavigator navigator;
  final GetNotificationSettingsUseCase _getNotificationSettingsUseCase;
  final UpdateNotificationSettingsUseCase _updateNotificationSettingsUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  NotificationSettingsPresentationModel get _model => state as NotificationSettingsPresentationModel;

  void onTapToggle(NotificationItem item) => _updateNotificationSettingsUseCase
          .execute(
        notificationSettings: _model.notificationSettings.copyAndToggleItem(item),
      )
          .doOn(
        success: (success) {
          _logAnalyticsEventUseCase.execute(
            AnalyticsEvent.tap(
              target: AnalyticsTapTarget.settingsNotificationsToggle,
              targetValue: item.value,
              secondaryTargetValue: _model.notificationSettings.settingForItem(item).toString(),
            ),
          );
          tryEmit(
            _model.copyWith(
              notificationSettings: _model.notificationSettings.copyAndToggleItem(item),
            ),
          );
        },
      );

  Future<void> onInit() async => getNotificationSettings();

  void getNotificationSettings() => _getNotificationSettingsUseCase
      .execute()
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(notificationSettingsResult: result)),
      )
      .doOn(
        success: (result) => tryEmit(_model.copyWith(notificationSettings: result)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );
}

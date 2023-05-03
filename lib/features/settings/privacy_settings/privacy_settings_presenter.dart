import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_privacy_settings_use_case.dart';
import 'package:picnic_app/features/settings/domain/use_cases/update_privacy_settings_use_case.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class PrivacySettingsPresenter extends Cubit<PrivacySettingsViewModel> {
  PrivacySettingsPresenter(
    PrivacySettingsPresentationModel model,
    this.navigator,
    this._updatePrivacySettingsUseCase,
    this._openNativeAppSettingsUseCase,
    this._requestRuntimePermissionUseCase,
    this._getPrivacySettingsUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final PrivacySettingsNavigator navigator;
  final UpdatePrivacySettingsUseCase _updatePrivacySettingsUseCase;
  final GetPrivacySettingsUseCase _getPrivacySettingsUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  PrivacySettingsPresentationModel get _model => state as PrivacySettingsPresentationModel;

  void onTapToggle({required bool selected}) => _updatePrivacySettingsUseCase
          .execute(
        onlyDMFromFollowed: selected,
      )
          .doOn(
        success: (success) {
          _logAnalyticsEventUseCase.execute(
            AnalyticsEvent.tap(
              target: AnalyticsTapTarget.settingsPrivacyToggle,
              targetValue: appLocalizations.privacySettingsOnlyReceiveDmsFromPeopleYouFollow,
              secondaryTargetValue: selected.toString(),
            ),
          );
          tryEmit(
            _model.copyWith(
              privacySettings: _model.privacySettings.copyWith(directMessagesFromAccountsYouFollow: selected),
            ),
          );
        },
      );

  void onTapToggleAccessListContacts({required bool selected}) {
    navigator.showAllowAccessContactConfirmation(
      onTakeToSettings: _openNativeAppSettingsUseCase.execute,
      onClose: navigator.close,
    );
  }

  void onTabDeleteAccount() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsPrivacyDeleteAccountTap,
      ),
    );
    navigator.showDeleteAccountConfirmation(
      onTapDelete: () {
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(
            target: AnalyticsTapTarget.settingsPrivacyDeleteAccountYesTap,
          ),
        );
        navigator.openDeleteAccount(const DeleteAccountInitialParams());
      },
      onTapClose: () {
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(
            target: AnalyticsTapTarget.settingsPrivacyDeleteAccountNoTap,
          ),
        );
      },
    );
  }

  Future<void> onInit() async {
    requestContactsPermission();
    getPrivacySettings();
  }

  void getPrivacySettings() => _getPrivacySettingsUseCase
      .execute() //

      .observeStatusChanges(
        (result) {
          tryEmit(_model.copyWith(privacySettingsResult: result));
        },
      )
      .doOn(
        success: (result) => tryEmit(
          _model.copyWith(
            privacySettings: result.copyWith(
              accessListOfContacts: _model.isAllowAccessContactGranted,
            ),
          ),
        ),
      )
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  void requestContactsPermission() =>
      _requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts).doOn(
            success: (status) => tryEmit(_model.copyWith(permissionStatus: status)),
            fail: (status) => tryEmit(
              _model.copyWith(permissionStatus: RuntimePermissionStatus.denied),
            ),
          );
}

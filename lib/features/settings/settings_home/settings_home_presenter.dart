import 'package:bloc/bloc.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/copy_text_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class SettingsHomePresenter extends Cubit<SettingsHomeViewModel> {
  SettingsHomePresenter(
    SettingsHomePresentationModel model,
    this.navigator,
    this._logOutUseCase,
    this._appInfoStore,
    this._copyTextUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final SettingsHomeNavigator navigator;
  final LogOutUseCase _logOutUseCase;
  final AppInfoStore _appInfoStore;
  final CopyTextUseCase _copyTextUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  SettingsHomePresentationModel get _model => state as SettingsHomePresentationModel;

  void onInit() => tryEmit(_model.copyWith(appInfo: _appInfoStore.appInfo));

  void onTapBlockedList() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsBlockedListTap,
      ),
    );
    navigator.openBlockedList(const BlockedListInitialParams());
  }

  void onTapCommunityGuidelines() => navigator.openCommunityGuidelines(const CommunityGuidelinesInitialParams());

  void onTapInviteFriends() => _model.enableInviteContactListPage
      ? navigator.openInviteFriends(InviteFriendsInitialParams(inviteLink: _model.inviteLink))
      : onTapShareLink();

  void onTapShareLink() => navigator.shareText(text: _model.inviteLink);

  void onTapReport() {
    navigator.openReportForm(
      const ReportFormInitialParams(),
    );
  }

  void onTapGetVerified() => navigator.openGetVerified(const GetVerifiedInitialParams());

  void onTapNotificationSettings() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsNotificationsTap,
      ),
    );
    navigator.openNotificationSettings(const NotificationSettingsInitialParams());
  }

  void onTapPrivacySettings() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsPrivacyTap,
      ),
    );
    navigator.openPrivacySettings(const PrivacySettingsInitialParams());
  }

  void onTapShareProfile() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsShareProfileTap,
      ),
    );
    navigator.shareText(text: _model.shareLink);
  }

  void onTapSignOut() => navigator.showConfirmationBottomSheet(
        title: appLocalizations.signOutAction,
        message: appLocalizations.signOutConfirmation,
        primaryAction: ConfirmationAction(
          roundedButton: true,
          title: appLocalizations.signOutButtonLabel,
          action: () {
            _logOutUseCase.execute().doOn(
              success: (success) {
                _logAnalyticsEventUseCase.execute(
                  AnalyticsEvent.tap(
                    target: AnalyticsTapTarget.settingsSignOutTap,
                  ),
                );
                navigator.replaceAllToOnboarding(const OnboardingInitialParams());
              },
            );
          },
        ),
        secondaryAction: ConfirmationAction.negative(
          action: () => navigator.close(),
        ),
      );

  void onLongPressAppInfo() => _copyTextUseCase.execute(text: state.appInfo.copiedInfo).doOn(
        success: (_) => navigator.showAppInfoBottomSheet(
          appInfo: state.appInfo,
          onTapClose: () => navigator.close(),
        ),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onTapTerms() => navigator.openUrl(Constants.termsUrl);

  void onTapPolicies() => navigator.openUrl(Constants.policiesUrl);
}

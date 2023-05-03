import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/widgets/invite_user_bottom_sheet.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class CircleSettingsPresenter extends Cubit<CircleSettingsViewModel> {
  CircleSettingsPresenter(
    CircleSettingsPresentationModel model,
    this.navigator,
    this._clipboardManager,
    this._getCircleDetailsUseCase,
  ) : super(model);

  static const int relatedMessagesCount = 20;

  final CircleSettingsNavigator navigator;

  final ClipboardManager _clipboardManager;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  CircleSettingsPresentationModel get _model => state as CircleSettingsPresentationModel;

  void onInit() => _getCircleDetails();

  Future<void> onTapSendPushNotification() async {
    if (_model.hasPermissionToManageCircle) {
      final isNotificationSent = await navigator.openSendPushNotification(const SendPushNotificationInitialParams());
      if (isNotificationSent != null && isNotificationSent) {
        tryEmit(
          _model.copyWith(
            notificationTimeStamp: _model.currentTimeProvider.currentTime.add(
              /// TODO: This value either needs to be fetched from backend or needs to be hardcoded somewhere in the app
              const Duration(minutes: 2),
            ),
          ),
        );
      }
    } else {
      await _showDisabledFeatureBottomSheet(
        title: appLocalizations.sendNotificationsRestrictedTitle,
        description: appLocalizations.sendNotificationsRestrictedDescription,
      );
    }
  }

  // TODO(GS-2939): Unit test - Circle Settings page copy invite link to the clipboard
  void onTapInviteUsers() {
    if (_model.hasPermissionToManageUsers) {
      showPicnicBottomSheet(
        InviteUserBottomSheet(
          onTapClose: () => navigator.close(),
          onTapCopyLink: () async {
            await _clipboardManager.saveText(_model.circle.inviteCircleLink);
            navigator.close();
            await navigator.showSnackBar(appLocalizations.invitationLinkCopiedMessage);
          },
          onTapInvite: () => navigator.openInviteUserList(
            InviteUserListInitialParams(circleId: _model.circle.id),
          ),
        ),
      );
    } else {
      _showDisabledFeatureBottomSheet(
        title: appLocalizations.inviteUsersRestrictedTitle,
        description: appLocalizations.inviteUsersRestrictedDescription,
      );
    }
  }

  void onTapLinkDiscord() => navigator.openLinkDiscord(LinkDiscordInitialParams(circleId: _model.circle.id));

  Future<void> onTapEditCircle() async {
    if (_model.hasPermissionToManageCircle) {
      final updatedCircle = await navigator.openEditCircle(
        EditCircleInitialParams(
          circle: _model.circle,
        ),
      );
      if (updatedCircle != null) {
        tryEmit(
          _model.byUpdatingCircle(updatedCircle),
        );
        _model.onCircleUpdatedCallback?.call();
      }
    } else {
      await _showDisabledFeatureBottomSheet(
        title: appLocalizations.editCircleRestrictedTitle,
        description: appLocalizations.editCircleRestrictedDescription,
      );
    }
  }

  void onTapOpenBlackListedWords() {
    if (_model.hasPermissionToManageCircle) {
      navigator.openBlacklistedWords(
        BlacklistedWordsInitialParams(circleId: _model.circle.id),
      );
    } else {
      _showDisabledFeatureBottomSheet(
        title: appLocalizations.manageBlacklistedWordsRestrictedTitle,
        description: appLocalizations.manageBlacklistedWordsRestrictedDescription,
      );
    }
  }

  Future<void> onTapReportsList() async {
    if (_model.hasPermissionToManageReports) {
      await navigator.openReportsList(
        ReportsListInitialParams(circle: _model.circle, onCirclePostDeleted: _model.onCirclePostDeletedCallback),
      );
      await _getCircleDetails();
    } else {
      await _showDisabledFeatureBottomSheet(
        title: appLocalizations.manageReportsRestrictedTitle,
        description: appLocalizations.manageReportsRestrictedDescription,
      );
    }
  }

  void onTapBannedUsersList() {
    if (_model.hasPermissionToManageUsers) {
      navigator.openBannedUsers(BannedUsersInitialParams(circle: _model.circle));
    } else {
      _showDisabledFeatureBottomSheet(
        title: appLocalizations.banUsersRestrictedTitle,
        description: appLocalizations.banUsersRestrictedDescription,
      );
    }
  }

  Future<void> onTapCircleConfig() async {
    if (_model.hasPermissionToConfigCircle) {
      final updatedCircle = await navigator.openCircleConfig(CircleConfigInitialParams(circle: _model.circle));
      if (updatedCircle != null) {
        tryEmit(
          _model.byUpdatingCircle(updatedCircle),
        );
        _model.onCircleUpdatedCallback?.call();
      }
    } else {
      await _showDisabledFeatureBottomSheet(
        title: appLocalizations.manageCircleConfigRestrictedTitle,
        description: appLocalizations.manageCircleConfigRestrictedDescription,
      );
    }
  }

  //TODO https://picnic-app.atlassian.net/browse/GS-5391
  void onTapPrivacyAndDiscoverability() => doNothing();

  void onTapRoles() {
    if (_model.hasPermissionToManageRoles) {
      navigator.openRolesList(
        RolesListInitialParams(
          circleId: _model.circle.id,
          hasPermissionToManageRoles: _model.hasPermissionToManageRoles,
        ),
      );
    } else {
      _showDisabledFeatureBottomSheet(
        title: appLocalizations.manageRolesRestrictedTitle,
        description: appLocalizations.manageRolesRestrictedDescription,
      );
    }
  }

  Future<void> _showDisabledFeatureBottomSheet({
    required String title,
    required String description,
  }) =>
      navigator.showDisabledBottomSheet(
        title: title,
        description: description,
        onTapClose: () => navigator.close(),
      );

  Future<void> _getCircleDetails() => _getCircleDetailsUseCase.execute(circleId: _model.circle.id).doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (circle) {
          if (_model.circle != circle) {
            tryEmit(_model.copyWith(circle: circle));
            _model.onCircleUpdatedCallback?.call();
          }
        },
      );
}

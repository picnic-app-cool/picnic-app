import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presenter.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/cooldown_timer_text.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_chevron_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

class CircleSettingsPage extends StatefulWidget with HasPresenter<CircleSettingsPresenter> {
  const CircleSettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleSettingsPresenter presenter;

  @override
  State<CircleSettingsPage> createState() => _CircleSettingsPageState();
}

class _CircleSettingsPageState extends State<CircleSettingsPage>
    with
        PresenterStateMixin<CircleSettingsViewModel, CircleSettingsPresenter, CircleSettingsPage>,
        SingleTickerProviderStateMixin {
  static const EdgeInsets _listItemPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final unresolvedReportsCount = state.circle.reportsCount;
    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.circleSettingsTitle,
        ),
        body: stateObserver(
          builder: (context, state) => ListView(
            children: [
              if (state.isSendingPushEnabled)
                PicnicChevronButton(
                  emoji: '🔔',
                  trailingWidget: CooldownTimerText(
                    key: ValueKey(state.notificationTimeStamp),
                    timeStamp: state.notificationTimeStamp,
                    currentTimeProvider: state.currentTimeProvider,
                  ),
                  label: appLocalizations.sendNotification,
                  padding: _listItemPadding,
                  buttonEnabled: state.hasPermissionToManageCircle,
                  onTap: presenter.onTapSendPushNotification,
                ),
              PicnicChevronButton(
                emoji: '🚩️',
                label: appLocalizations.reportsTabAction,
                trailingWidget: unresolvedReportsCount > 0 ? PicnicBadge(count: unresolvedReportsCount) : null,
                padding: _listItemPadding,
                buttonEnabled: state.hasPermissionToManageReports,
                onTap: presenter.onTapReportsList,
              ),
              if (state.isCustomRolesEnabled)
                PicnicChevronButton(
                  emoji: '👥',
                  label: appLocalizations.roles,
                  padding: _listItemPadding,
                  buttonEnabled: state.hasPermissionToManageRoles,
                  onTap: presenter.onTapRoles,
                ),
              stateObserver(
                builder: (context, state) => PicnicChevronButton(
                  emoji: '📨',
                  label: appLocalizations.inviteAction,
                  padding: _listItemPadding,
                  buttonEnabled: state.hasPermissionToManageUsers,
                  onTap: presenter.onTapInviteUsers,
                ),
              ),
              if (state.isLinkDiscordAvailable)
                PicnicChevronButton(
                  imagePath: Assets.images.discord.path,
                  label: appLocalizations.linkDiscord,
                  padding: _listItemPadding,
                  onTap: presenter.onTapLinkDiscord,
                ),
              PicnicChevronButton(
                emoji: '⛔',
                label: appLocalizations.banUsersAction,
                padding: _listItemPadding,
                buttonEnabled: state.hasPermissionToManageUsers,
                onTap: presenter.onTapBannedUsersList,
              ),
              PicnicChevronButton(
                emoji: '🚫️',
                label: appLocalizations.blacklistedWords,
                padding: _listItemPadding,
                buttonEnabled: state.hasPermissionToManageCircle,
                onTap: presenter.onTapOpenBlackListedWords,
              ),
              PicnicChevronButton(
                emoji: '✍️',
                label: appLocalizations.editCircle,
                padding: _listItemPadding,
                buttonEnabled: state.hasPermissionToManageCircle,
                onTap: presenter.onTapEditCircle,
              ),
              if (state.isCircleConfigEnabled)
                PicnicChevronButton(
                  emoji: '⚙️',
                  label: appLocalizations.circleConfig,
                  padding: _listItemPadding,
                  buttonEnabled: state.hasPermissionToConfigCircle,
                  onTap: presenter.onTapCircleConfig,
                ),
              if (state.isCirclePrivacyDiscoverableEnabled)
                PicnicChevronButton(
                  emoji: '🔏️',
                  label: appLocalizations.privacyDiscoverability,
                  padding: _listItemPadding,
                  buttonEnabled: state.hasPermissionToChangePrivacy,
                  onTap: presenter.onTapPrivacyAndDiscoverability,
                ),
              const Gap(24.0),
            ],
          ),
        ),
      ),
    );
  }
}

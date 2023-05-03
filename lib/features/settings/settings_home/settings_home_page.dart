// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presenter.dart';
import 'package:picnic_app/features/settings/widgets/app_info_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_chevron_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SettingsHomePage extends StatefulWidget with HasPresenter<SettingsHomePresenter> {
  const SettingsHomePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SettingsHomePresenter presenter;

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage>
    with PresenterStateMixin<SettingsHomeViewModel, SettingsHomePresenter, SettingsHomePage> {
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 8,
  );
  static const EdgeInsets _listItemPadding = EdgeInsets.only(
    left: 24,
    right: 24,
    bottom: 24,
  );
  static const _buttonBorderWidth = 2.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final pink = colors.pink;

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.settings,
        ),
        body: ListView(
          children: [
            const Gap(4),
            if (state.isLanguageSettingsEnabled)
              PicnicChevronButton(
                emoji: '🌎',
                label: appLocalizations.settingsLanguage,
                padding: _listItemPadding,
                onTap: presenter.onTapLanguage,
              ),
            PicnicChevronButton(
              emoji: '⛔️',
              label: appLocalizations.settingsBlockedList,
              padding: _listItemPadding,
              onTap: presenter.onTapBlockedList,
            ),
            PicnicChevronButton(
              emoji: '📚',
              label: appLocalizations.settingsCommunityGuidelines,
              padding: _listItemPadding,
              onTap: presenter.onTapCommunityGuidelines,
            ),
            stateObserver(
              builder: (context, state) => PicnicChevronButton(
                emoji: '👥',
                label: appLocalizations.settingsInviteFriends,
                padding: _listItemPadding,
                onTap: presenter.onTapInviteFriends,
              ),
            ),
            PicnicChevronButton(
              emoji: '✅',
              label: appLocalizations.settingsGetVerified,
              padding: _listItemPadding,
              onTap: presenter.onTapGetVerified,
            ),
            PicnicChevronButton(
              emoji: '⚙️',
              label: appLocalizations.settingsNotificationSettings,
              padding: _listItemPadding,
              onTap: presenter.onTapNotificationSettings,
            ),
            PicnicChevronButton(
              emoji: '🔒',
              label: appLocalizations.settingsPrivacySettings,
              padding: _listItemPadding,
              onTap: presenter.onTapPrivacySettings,
            ),
            PicnicChevronButton(
              emoji: '🔗',
              label: appLocalizations.settingsShareProfile,
              padding: _listItemPadding,
              onTap: presenter.onTapShareProfile,
            ),
            PicnicChevronButton(
              emoji: '❗️',
              label: appLocalizations.reportProblem,
              padding: _listItemPadding,
              onTap: presenter.onTapReport,
            ),
            PicnicChevronButton(
              emoji: '📜',
              label: appLocalizations.termsAndConditionsLabel,
              padding: _listItemPadding,
              onTap: presenter.onTapTerms,
            ),
            PicnicChevronButton(
              emoji: '🛡️',
              label: appLocalizations.privacyPolicyLabel,
              padding: _listItemPadding,
              onTap: presenter.onTapPolicies,
            ),
            const Gap(84.0),
            Center(
              child: PicnicButton(
                title: appLocalizations.signOutAction,
                style: PicnicButtonStyle.outlined,
                titleColor: pink,
                onTap: presenter.onTapSignOut,
                padding: _buttonPadding,
                borderWidth: _buttonBorderWidth,
                borderColor: pink,
              ),
            ),
            const Gap(32),
            stateObserver(
              builder: (context, state) => AppInfoView(
                info: state.appInfo,
                onLongPressAppInfo: presenter.onLongPressAppInfo,
              ),
            ),
            const Gap(24.0),
          ],
        ),
      ),
    );
  }
}

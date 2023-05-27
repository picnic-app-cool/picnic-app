// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PrivacySettingsPage extends StatefulWidget with HasPresenter<PrivacySettingsPresenter> {
  const PrivacySettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PrivacySettingsPresenter presenter;

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage>
    with PresenterStateMixin<PrivacySettingsViewModel, PrivacySettingsPresenter, PrivacySettingsPage> {
  static const _buttonBorderWidth = 2.0;

  static const _maxLines = 2;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final pinkColor = colors.pink;
    final itemTextStyle = theme.styles.subtitle30;

    final appBar = PicnicAppBar(
      backgroundColor: theme.colors.blackAndWhite.shade100,
      titleText: appLocalizations.privacySettingsTitle,
    );

    final deleteButton = PicnicButton(
      minWidth: 100,
      title: appLocalizations.deleteAccountAction,
      borderColor: pinkColor,
      titleColor: pinkColor,
      color: Colors.white,
      style: PicnicButtonStyle.outlined,
      borderWidth: _buttonBorderWidth,
      onTap: presenter.onTabDeleteAccount,
    );

    return stateObserver(
      builder: (context, state) => DarkStatusBar(
        child: Scaffold(
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: PicnicListItem(
                      title: appLocalizations.privacySettingsOnlyReceiveDmsFromPeopleYouFollow,
                      titleStyle: itemTextStyle,
                      maxLines: _maxLines,
                      trailing: state.isLoading
                          ? const PicnicLoadingIndicator()
                          : PicnicSwitch(
                              value: state.privacySettings.directMessagesFromAccountsYouFollow,
                              onChanged: (value) => presenter.onTapToggle(selected: value),
                              size: PicnicSwitchSize.regular,
                              color: colors.blue,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: PicnicListItem(
                        title: appLocalizations.privacySettingsAccessListContacts,
                        titleStyle: itemTextStyle,
                        maxLines: _maxLines,
                        trailing: state.isLoading
                            ? const PicnicLoadingIndicator()
                            : PicnicSwitch(
                                value: state.privacySettings.accessListOfContacts,
                                onChanged: (value) => presenter.onTapToggleAccessListContacts(
                                  selected: value,
                                ),
                                size: PicnicSwitchSize.regular,
                                color: colors.blue,
                              ),
                      ),
                    ),
                  ),
                  deleteButton,
                  const Gap(84),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

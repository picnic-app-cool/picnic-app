// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presenter.dart';
import 'package:picnic_app/features/settings/notification_settings/widgets/notification_settings_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class NotificationSettingsPage extends StatefulWidget with HasPresenter<NotificationSettingsPresenter> {
  const NotificationSettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final NotificationSettingsPresenter presenter;

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage>
    with PresenterStateMixin<NotificationSettingsViewModel, NotificationSettingsPresenter, NotificationSettingsPage> {
  static const _horizontalDividerHeight = 1.0;
  static const _sidePadding = 4.0;
  static const _divideGapHeight = 24.0;
  static const _divideSidePadding = 24.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    const sidePadding = EdgeInsets.symmetric(horizontal: _sidePadding);
    const divideSidePadding = EdgeInsets.symmetric(horizontal: _divideSidePadding);

    final horizontalDivider = Container(
      margin: divideSidePadding,
      color: colors.blackAndWhite.shade300,
      height: _horizontalDividerHeight,
    );

    final appBar = PicnicAppBar(
      backgroundColor: theme.colors.blackAndWhite.shade100,
      titleText: appLocalizations.settingsNotificationSettings,
    );

    return stateObserver(
      builder: (context, state) => DarkStatusBar(
        child: Scaffold(
          appBar: appBar,
          body: state.isLoading
              ? const Center(child: PicnicLoadingIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Padding(
                      padding: sidePadding,
                      child: Column(
                        children: [
                          NotificationSettingsListView(
                            items: state.firstNotificationsGroup,
                            notificationSettings: state.notificationSettings,
                            onTapToggle: presenter.onTapToggle,
                          ),
                          horizontalDivider,
                          const Gap(_divideGapHeight),
                          NotificationSettingsListView(
                            items: state.secondNotificationsGroup,
                            notificationSettings: state.notificationSettings,
                            onTapToggle: presenter.onTapToggle,
                          ),
                          horizontalDivider,
                          const Gap(_divideGapHeight),
                          NotificationSettingsListView(
                            items: state.thirdNotificationsGroup,
                            notificationSettings: state.notificationSettings,
                            onTapToggle: presenter.onTapToggle,
                          ),
                          horizontalDivider,
                          const Gap(_divideGapHeight),
                          NotificationSettingsListView(
                            items: state.fourthNotificationsGroup,
                            notificationSettings: state.notificationSettings,
                            onTapToggle: presenter.onTapToggle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

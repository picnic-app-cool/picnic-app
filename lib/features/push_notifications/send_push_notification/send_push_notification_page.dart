// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SendPushNotificationPage extends StatefulWidget with HasPresenter<SendPushNotificationPresenter> {
  const SendPushNotificationPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SendPushNotificationPresenter presenter;

  @override
  State<SendPushNotificationPage> createState() => _SendPushNotificationPageState();
}

class _SendPushNotificationPageState extends State<SendPushNotificationPage>
    with PresenterStateMixin<SendPushNotificationViewModel, SendPushNotificationPresenter, SendPushNotificationPage> {
  static const maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final blackAndWhite = theme.colors.blackAndWhite;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.sendPushNotificationTitle,
              style: styles.subtitle40,
            ),
            const Gap(20),
            PicnicTextInput(
              inputFillColor: blackAndWhite.shade200,
              hintText: appLocalizations.pastePostHintText,
              onChanged: presenter.onLinkChanged,
            ),
            PicnicTextInput(
              inputFillColor: blackAndWhite.shade200,
              hintText: appLocalizations.notificationBodyHintText,
              onChanged: presenter.onBodyChanged,
              maxLines: maxLines,
            ),
            const Gap(12),
            Text(
              appLocalizations.sendPushNotificationInfo,
              textAlign: TextAlign.center,
              style: styles.body10.copyWith(
                color: blackAndWhite.shade700,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: PicnicButton(
                    title: appLocalizations.sendPushNotificationAction,
                    icon: Assets.images.notification.path,
                    titleColor: blackAndWhite.shade100,
                    onTap: presenter.onTapSendNotification,
                  ),
                ),
              ],
            ),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: presenter.onTapClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

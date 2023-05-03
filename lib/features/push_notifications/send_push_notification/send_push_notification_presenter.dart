import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';

class SendPushNotificationPresenter extends Cubit<SendPushNotificationViewModel> {
  SendPushNotificationPresenter(
    SendPushNotificationPresentationModel model,
    this.navigator,
  ) : super(model);

  final SendPushNotificationNavigator navigator;

  // ignore: unused_element
  SendPushNotificationPresentationModel get _model => state as SendPushNotificationPresentationModel;

  void onTapClose() => navigator.closeWithResult(false);

  // TODO: Add send notification logic before closing bottom sheet
  void onTapSendNotification() => navigator.closeWithResult(true);

  void onLinkChanged(String value) => notImplemented();

  void onBodyChanged(String value) => notImplemented();
}

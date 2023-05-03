import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presenter.dart';

import '../mocks/push_notifications_mock_definitions.dart';

void main() {
  late SendPushNotificationPresentationModel model;
  late SendPushNotificationPresenter presenter;
  late MockSendPushNotificationNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = SendPushNotificationPresentationModel.initial(const SendPushNotificationInitialParams());
    navigator = MockSendPushNotificationNavigator();
    presenter = SendPushNotificationPresenter(
      model,
      navigator,
    );
  });
}

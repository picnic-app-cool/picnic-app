import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_page.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late SendPushNotificationPage page;
  late SendPushNotificationInitialParams initParams;
  late SendPushNotificationPresentationModel model;
  late SendPushNotificationPresenter presenter;
  late SendPushNotificationNavigator navigator;

  void _initMvp() {
    initParams = const SendPushNotificationInitialParams();
    model = SendPushNotificationPresentationModel.initial(
      initParams,
    );
    navigator = SendPushNotificationNavigator(Mocks.appNavigator);
    presenter = SendPushNotificationPresenter(
      model,
      navigator,
    );
    page = SendPushNotificationPage(presenter: presenter);
  }

  await screenshotTest(
    "send_push_notification_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SendPushNotificationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

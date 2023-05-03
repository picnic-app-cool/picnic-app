import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../../push_notifications/mocks/push_notifications_mock_definitions.dart';
import '../mocks/in_app_notifications_mock_definitions.dart';

void main() {
  late NotificationsPresenter presenter;
  late MockNotificationsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    navigator = MockNotificationsNavigator();
    presenter = NotificationsPresenter(
      navigator,
      MockGetInAppNotificationsUseCase(),
      MockToggleInAppNotificationsUseCase(),
      MockGetPushNotificationsUseCase(),
      MockAddDeepLinkUseCase(),
      Mocks.getUserUseCase,
      ProfileMocks.getUnreadNotificationsCountUseCase,
      Mocks.updateAppBadgeCountUseCase,
    );
  });
}

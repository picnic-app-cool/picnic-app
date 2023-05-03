import 'dart:async';
import 'dart:ui';

import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_glitterbomb.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/core/domain/use_cases/add_deeplink_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/get_in_app_notifications_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/toggle_in_app_notifications_use_case.dart';
import 'package:picnic_app/features/in_app_events/in_app_event_presentable.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_navigator.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/get_push_notifications_use_case.dart';

class NotificationsPresenter implements InAppEventPresentable {
  NotificationsPresenter(
    this.navigator,
    this._getInAppNotificationsUseCase,
    this._toggleInAppNotificationsUseCase,
    this._getPushNotificationsUseCase,
    this._addDeepLinkUseCase,
    this._getUserUseCase,
    this._getUnreadNotificationsCountUseCase,
    this._updateAppBadgeCountUseCase,
  );

  final NotificationsNavigator navigator;
  final GetInAppNotificationsUseCase _getInAppNotificationsUseCase;
  final ToggleInAppNotificationsUseCase _toggleInAppNotificationsUseCase;
  final GetPushNotificationsUseCase _getPushNotificationsUseCase;
  final AddDeepLinkUseCase _addDeepLinkUseCase;
  final GetUserUseCase _getUserUseCase;
  final GetUnreadNotificationsCountUseCase _getUnreadNotificationsCountUseCase;
  final UpdateAppBadgeCountUseCase _updateAppBadgeCountUseCase;

  StreamSubscription<Notification>? _inAppNotificationsEventSub;
  StreamSubscription<Notification>? _pushNotificationsEventSub;

  @override
  Future<void> onInit() async {
    final stream = await _getInAppNotificationsUseCase.execute();
    _inAppNotificationsEventSub = stream.listen(_processInAppNotification);

    _pushNotificationsEventSub = _getPushNotificationsUseCase.execute().listen(_processPushNotification);

    await _updateAppBadge();
  }

  @override
  Future<void> dispose() async {
    unawaited(_inAppNotificationsEventSub?.cancel());
    unawaited(_pushNotificationsEventSub?.cancel());
  }

  @override
  void onAppLifecycleStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _toggleInAppNotificationsUseCase.execute(enable: false);
    } else if (state == AppLifecycleState.resumed) {
      _toggleInAppNotificationsUseCase.execute(enable: true);

      _updateAppBadge();
    }
  }

  void _processInAppNotification(Notification notification) {
    navigator.showInAppNotification(
      message: notification.message,
      onTap: () => _addDeepLinkUseCase.execute(
        deepLink: notification.toDeepLink(),
      ),
    );
    if (notification.type == NotificationType.glitterbomb) {
      _showGlitterBomb((notification as NotificationGlitterbomb).userId);
    }
  }

  void _processPushNotification(Notification notification) {
    _addDeepLinkUseCase.execute(deepLink: notification.toDeepLink());
    if (notification.type == NotificationType.glitterbomb) {
      _showGlitterBomb((notification as NotificationGlitterbomb).userId);
    }
  }

  void _showGlitterBomb(Id userId) {
    navigator.showFxEffect(LottieFxEffect.glitter());

    _getUserUseCase.execute(userId: userId).doOn(
          success: (profile) => navigator.showFxEffect(
            ConfettiFxEffect.avatar(profile.profileImageUrl),
          ),
        );
  }

  Future<void> _updateAppBadge() => _getUnreadNotificationsCountUseCase.execute().doOn(
        success: (count) => _updateAppBadgeCountUseCase.execute(count.count),
      );
}

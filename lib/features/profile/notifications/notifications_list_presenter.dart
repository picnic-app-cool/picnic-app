import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/add_deeplink_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/get_notifications_failure.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_notifications_use_case.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';

class NotificationsListPresenter extends Cubit<NotificationsViewModel> {
  NotificationsListPresenter(
    NotificationsListPresentationModel model,
    this.navigator,
    this._getNotificationsUseCase,
    this._followUnfollowUseCase,
    this._logAnalyticsEventUseCase,
    this._addDeepLinkUseCase,
    this._joinCircleUseCase,
  ) : super(model);

  final NotificationsListNavigator navigator;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final AddDeepLinkUseCase _addDeepLinkUseCase;
  final JoinCircleUseCase _joinCircleUseCase;

  NotificationsListPresentationModel get _model => state as NotificationsListPresentationModel;

  Future<Either<GetNotificationsFailure, PaginatedList<ProfileNotification>>> loadNotifications({
    bool fromScratch = false,
  }) {
    return _getNotificationsUseCase
        .execute(
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.notifications.nextPageCursor(),
          refresh: fromScratch,
        )
        .doOn(
          success: (notifications) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(notifications: notifications)
                  : _model.byAppendingNotificationsList(newList: notifications),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onInit() {
    _onPostRemoved();
  }

  void onNotificationBodyTap({required ProfileNotification notification}) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileNotificationsListTap,
      ),
    );
    _addDeepLinkUseCase.execute(deepLink: notification.toDeepLink());
  }

  void onTapToggleFollow({
    required Id userId,
    required bool iFollow,
  }) {
    final previousFollowingState = iFollow;
    tryEmit(_model.byUpdateFollowAction(userId: userId, iFollow: !iFollow));

    _followUnfollowUseCase.execute(userId: userId, follow: !iFollow).doOn(
      fail: (fail) {
        tryEmit(_model.byUpdateFollowAction(userId: userId, iFollow: previousFollowingState));
        navigator.showError(fail.displayableFailure());
      },
    ).observeStatusChanges(
      (result) => tryEmit(_model.copyWith(followResults: _model.followResults..[userId] = result)),
    );
  }

  Future<void> onTapJoin(Id circleId) async {
    tryEmit(_model.byUpdatingJoinStatus(circleId: circleId, joined: true));
    await _joinCircleUseCase.execute(circleId: circleId).doOn(
      fail: (fail) {
        tryEmit(_model.byUpdatingJoinStatus(circleId: circleId, joined: true));
        navigator.showError(fail.displayableFailure());
      },
    );
  }

  void _onPostRemoved() {
    if (_model.showPostRemovedBottomSheet) {
      // TODO(GS-5192): Implement the logic to remove the notification when the post is removed when the API is ready.
      Future.delayed(
        const Duration(seconds: 1),
        () => navigator.openPostRemovedBottomSheet(),
      );
    }
  }
}

import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_follow.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_user_invited_to_circle.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class NotificationsListPresentationModel implements NotificationsViewModel {
  /// Creates the initial state
  NotificationsListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    NotificationsListInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : notifications = const PaginatedList.empty(),
        followResults = <Id, FutureResult<void>>{},
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  NotificationsListPresentationModel._({
    required this.notifications,
    required this.followResults,
    required this.featureFlags,
  });

  final FeatureFlags featureFlags;

  @override
  final PaginatedList<ProfileNotification> notifications;

  @override
  final Map<Id, FutureResult<void>> followResults;

  @override
  bool get showPostRemovedBottomSheet => featureFlags[FeatureFlagType.showPostRemovedBottomSheet];

  @override
  bool isFollowProcessing(Id id) {
    return followResults[id]?.isPending() ?? false;
  }

  NotificationsListPresentationModel byUpdateFollowAction({
    required Id userId,
    required bool iFollow,
  }) {
    return copyWith(
      notifications: notifications.mapItems((element) {
        if (element.userId == userId && element is ProfileNotificationFollow) {
          return element.copyWith(iFollow: iFollow);
        }
        return element;
      }),
    );
  }

  NotificationsListPresentationModel byUpdatingJoinStatus({
    required Id circleId,
    required bool joined,
  }) {
    return copyWith(
      notifications: notifications.mapItems((it) {
        if (it is ProfileNotificationUserInvitedToCircle && it.circleId == circleId) {
          return it.copyWith(joined: joined);
        }
        return it;
      }),
    );
  }

  NotificationsListPresentationModel byAppendingNotificationsList({
    required PaginatedList<ProfileNotification> newList,
  }) {
    return copyWith(
      notifications: notifications + newList,
    );
  }

  NotificationsListPresentationModel copyWith({
    PaginatedList<ProfileNotification>? notifications,
    Map<Id, FutureResult<void>>? followResults,
    FeatureFlags? featureFlags,
  }) =>
      NotificationsListPresentationModel._(
        notifications: notifications ?? this.notifications,
        followResults: followResults ?? this.followResults,
        featureFlags: featureFlags ?? this.featureFlags,
      );
}

/// Interface to expose fields used by the view (page).
abstract class NotificationsViewModel {
  PaginatedList<ProfileNotification> get notifications;

  Map<Id, FutureResult<void>> get followResults;

  bool get showPostRemovedBottomSheet;

  bool isFollowProcessing(Id id);
}

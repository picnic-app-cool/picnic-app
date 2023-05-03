import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/settings/domain/model/get_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/notification_item.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class NotificationSettingsPresentationModel implements NotificationSettingsViewModel {
  /// Creates the initial state
  NotificationSettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    NotificationSettingsInitialParams initialParams,
  )   : notificationSettingsResult = const FutureResult.empty(),
        notificationSettings = const NotificationSettings.empty();

  /// Used for the copyWith method
  NotificationSettingsPresentationModel._({
    required this.notificationSettings,
    required this.notificationSettingsResult,
  });

  @override
  final NotificationSettings notificationSettings;

  final FutureResult<Either<GetNotificationSettingsFailure, NotificationSettings>> notificationSettingsResult;

  @override
  List<NotificationItem> get firstNotificationsGroup => List.unmodifiable([
        NotificationItem.likes,
        NotificationItem.comments,
        NotificationItem.commentLikes,
        NotificationItem.postSaves,
        NotificationItem.postShares,
        NotificationItem.glitterBombs,
        NotificationItem.newFollowers,
        NotificationItem.mentions,
      ]);

  @override
  List<NotificationItem> get secondNotificationsGroup => List.unmodifiable([
        NotificationItem.directMessages,
        NotificationItem.postsFromAccountsYouFollow,
      ]);

  @override
  List<NotificationItem> get thirdNotificationsGroup => List.unmodifiable([
        NotificationItem.circleChats,
        NotificationItem.groupChats,
      ]);

  @override
  List<NotificationItem> get fourthNotificationsGroup => List.unmodifiable([
        NotificationItem.seeds,
        NotificationItem.circleJoins,
        NotificationItem.circleInvites,
      ]);

  @override
  bool get isLoading => notificationSettingsResult.isPending();

  NotificationSettingsPresentationModel copyWith({
    FutureResult<Either<GetNotificationSettingsFailure, NotificationSettings>>? notificationSettingsResult,
    NotificationSettings? notificationSettings,
  }) {
    return NotificationSettingsPresentationModel._(
      notificationSettingsResult: notificationSettingsResult ?? this.notificationSettingsResult,
      notificationSettings: notificationSettings ?? this.notificationSettings,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class NotificationSettingsViewModel {
  List<NotificationItem> get firstNotificationsGroup;

  List<NotificationItem> get secondNotificationsGroup;

  List<NotificationItem> get thirdNotificationsGroup;

  List<NotificationItem> get fourthNotificationsGroup;

  NotificationSettings get notificationSettings;

  bool get isLoading;
}

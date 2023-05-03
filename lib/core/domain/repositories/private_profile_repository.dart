import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/set_language_failure.dart';
import 'package:picnic_app/features/profile/domain/model/edit_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_notifications_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_private_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_unread_notifications_count_failure.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/model/update_profile_image_failure.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';
import 'package:picnic_app/features/settings/domain/model/get_block_list_failure.dart';
import 'package:picnic_app/features/settings/domain/model/get_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/get_privacy_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';
import 'package:picnic_app/features/settings/domain/model/request_delete_account_failure.dart';
import 'package:picnic_app/features/settings/domain/model/update_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/update_privacy_settings_failure.dart';

abstract class PrivateProfileRepository {
  Future<Either<GetNotificationSettingsFailure, NotificationSettings>> getNotificationSettings();

  Future<Either<UpdatePrivacySettingsFailure, Unit>> updatePrivacySettings({required bool onlyDMFromFollowed});

  Future<Either<UpdateNotificationSettingsFailure, Unit>> updateNotificationSettings({
    required NotificationSettings notificationSettings,
  });

  Future<Either<GetBlockListFailure, PaginatedList<PublicProfile>>> getBlockList({required Cursor cursor});

  Future<Either<GetPrivacySettingsFailure, PrivacySettings>> getPrivacySettings();

  Future<Either<GetPrivateProfileFailure, PrivateProfile>> getPrivateProfile();

  Future<Either<SetLanguageFailure, Unit>> setLanguage({required List<String> languagesCodes});

  Future<Either<EditProfileFailure, Unit>> editPrivateProfile({
    String? username,
    String? fullName,
    String? bio,
    int? age,
  });

  Future<Either<RequestDeleteAccountFailure, Unit>> requestDeleteAccount({
    required DeleteAccountReasonInput deleteAccountReasonInput,
  });

  Future<Either<UpdateProfileImageFailure, ImageUrl>> updateProfileImage({
    required String filePath,
  });

  Future<Either<GetNotificationsFailure, PaginatedList<ProfileNotification>>> getNotificationList({
    required Cursor cursor,
  });

  Future<Either<GetUnreadNotificationsCountFailure, UnreadNotificationsCount>> getUnreadNotificationsCount();

  Future<void> markAllNotificationsAsRead();
}

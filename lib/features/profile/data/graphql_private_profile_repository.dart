import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_notification_settings.dart';
import 'package:picnic_app/core/data/graphql/model/gql_privacy_settings.dart';
import 'package:picnic_app/core/data/graphql/model/gql_private_profile.dart';
import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user_profile_image_input.dart';
import 'package:picnic_app/core/data/graphql/users_queries.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/set_language_failure.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/profile/data/graphql/gql_unread_notifications_count.dart';
import 'package:picnic_app/features/profile/data/model/gql_profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/edit_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_notifications_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_private_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_unread_notifications_count_failure.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/model/update_profile_image_failure.dart';
import 'package:picnic_app/features/settings/data/model/gql_notification_settings_input.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';
import 'package:picnic_app/features/settings/domain/model/get_block_list_failure.dart';
import 'package:picnic_app/features/settings/domain/model/get_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/get_privacy_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';
import 'package:picnic_app/features/settings/domain/model/request_delete_account_failure.dart';
import 'package:picnic_app/features/settings/domain/model/update_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/update_privacy_settings_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlPrivateProfileRepository with FutureRetarder implements PrivateProfileRepository {
  const GraphqlPrivateProfileRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetNotificationSettingsFailure, NotificationSettings>> getNotificationSettings() async {
    return _gqlClient
        .mutate(
          document: getNotificationSettingsQuery,
          parseData: (json) =>
              GqlNotificationSettings.fromJson(asT<Map<String, dynamic>>(json, 'getNotificationSettings')),
        )
        .mapFailure((fail) => const GetNotificationSettingsFailure.unknown())
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<GetPrivateProfileFailure, PrivateProfile>> getPrivateProfile() async {
    return _gqlClient
        .query(
          document: getMyProfileQuery,
          parseData: (json) => GqlPrivateProfile.fromJson(asT(json, 'myProfile')),
        )
        .mapFailure(
          (fail) => GetPrivateProfileFailure.unknown(fail),
        )
        .mapSuccess(
          (response) => response.toDomain(),
        );
  }

  @override
  Future<Either<GetBlockListFailure, PaginatedList<PublicProfile>>> getBlockList({required Cursor cursor}) async {
    return _gqlClient
        .query(
          document: getBlockedUsersQuery,
          variables: {'cursor': cursor.toGqlCursorInput()},
          parseData: (json) {
            final data = json['blockedUsersConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure((fail) => GetBlockListFailure.unknown(fail))
        .mapSuccess(
          (response) => response.toDomain(
            nodeMapper: (node) => GqlPublicProfile.fromJson(node).toDomain(_userStore),
          ),
        );
  }

  @override
  Future<Either<GetNotificationsFailure, PaginatedList<ProfileNotification>>> getNotificationList({
    required Cursor cursor,
  }) async {
    return _gqlClient
        .query(
          document: getNotificationsQuery,
          variables: {'cursor': cursor.toGqlCursorInput()},
          parseData: (json) {
            final data = json['notificationGet'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure((fail) => GetNotificationsFailure.unknown(fail))
        .mapSuccess(
          (response) => response.toDomain(nodeMapper: (node) => GqlProfileNotification.fromJson(node).toDomain()),
        );
  }

  @override
  Future<Either<GetUnreadNotificationsCountFailure, UnreadNotificationsCount>> getUnreadNotificationsCount() async {
    return _gqlClient
        .query(
          document: getUnreadNotificationsCountQuery,
          parseData: (json) {
            final data = json['notificationGetUnreadCount'] as Map<String, dynamic>;
            return GqlUnreadNotificationsCount.fromJson(data);
          },
        )
        .mapFailure((fail) => GetUnreadNotificationsCountFailure.unknown(fail))
        .mapSuccess((response) => response.toDomain());
  }

  @override
  Future<Either<EditProfileFailure, Unit>> editPrivateProfile({
    String? username,
    String? fullName,
    String? bio,
    int? age,
  }) async {
    return _gqlClient
        .mutate(
          document: editMyProfileMutation,
          variables: {
            "username": username,
            "name": fullName,
            "bio": bio,
            "age": age,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['updateProfileInfo'] as Map<String, dynamic>),
        )
        .mapFailure((fail) => const EditProfileFailure.unknown())
        .mapSuccessPayload(onFailureReturn: const EditProfileFailure.unknown());
  }

  @override
  Future<Either<RequestDeleteAccountFailure, Unit>> requestDeleteAccount({
    required DeleteAccountReasonInput deleteAccountReasonInput,
  }) async {
    return _gqlClient
        .mutate(
          document: requestDeleteAccountMutation,
          variables: {
            'reason': '${deleteAccountReasonInput.deleteAccountReason}: ${deleteAccountReasonInput.description}',
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['deleteAccountRequest'] as Map<String, dynamic>),
        )
        .mapFailure((fail) => const RequestDeleteAccountFailure.unknown())
        .mapSuccessPayload(onFailureReturn: const RequestDeleteAccountFailure.unknown());
  }

  @override
  Future<Either<UpdatePrivacySettingsFailure, Unit>> updatePrivacySettings({required bool onlyDMFromFollowed}) {
    return _gqlClient
        .mutate(
          document: updatePrivacySettingsMutation,
          variables: {
            'OnlyDMFromFollowed': onlyDMFromFollowed,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['updatePrivacySettings'] as Map<String, dynamic>),
        )
        .mapFailure((fail) => const UpdatePrivacySettingsFailure.unknown())
        .mapSuccessPayload(onFailureReturn: const UpdatePrivacySettingsFailure.unknown());
  }

  @override
  Future<Either<GetPrivacySettingsFailure, PrivacySettings>> getPrivacySettings() {
    return _gqlClient
        .mutate(
          document: getPrivacySettingsMutation,
          parseData: (json) => GqlPrivacySettings.fromJson(asT(json, 'getPrivacySettings')),
        )
        .mapFailure((fail) => const GetPrivacySettingsFailure.unknown())
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<UpdateNotificationSettingsFailure, Unit>> updateNotificationSettings({
    required NotificationSettings notificationSettings,
  }) async {
    return _gqlClient
        .mutate(
          document: upsertNotificationSettingsMutation,
          variables: {
            'settings': notificationSettings.toJson(),
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['upsertNotificationSettings'] as Map<String, dynamic>),
        )
        .mapFailure((fail) => const UpdateNotificationSettingsFailure.unknown())
        .mapSuccessPayload(onFailureReturn: const UpdateNotificationSettingsFailure.unknown());
  }

  @override
  Future<Either<SetLanguageFailure, Unit>> setLanguage({required List<String> languagesCodes}) {
    return _gqlClient
        .mutate(
          document: updateUserPreferredLanguagesMutation,
          variables: {
            'languagesCodes': languagesCodes,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['updateUserPreferredLanguages'] as Map<String, dynamic>),
        )
        .mapFailure((fail) => const SetLanguageFailure.unknown())
        .mapSuccessPayload(onFailureReturn: const SetLanguageFailure.unknown());
  }

  @override
  Future<Either<UpdateProfileImageFailure, ImageUrl>> updateProfileImage({required String filePath}) => _gqlClient
      .mutate(
        document: updatePrivateProfileImage,
        variables: {
          'image': GqlUserProfileImageInput(profileImage: filePath).toJson(),
        },
        parseData: (json) => asT<String>(json, 'updateProfileImage'),
      )
      .mapFailure((fail) => const UpdateProfileImageFailure.unknown())
      .mapSuccess((imageUrl) => ImageUrl(imageUrl));

  @override
  Future<void> markAllNotificationsAsRead() {
    return _gqlClient.mutate(
      document: markAllNotificationsAsReadMutation,
      parseData: (json) {
        return unit;
      },
    );
  }
}

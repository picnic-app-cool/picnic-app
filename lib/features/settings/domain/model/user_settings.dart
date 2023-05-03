import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';

//ignore_for_file: unused-code, unused-files
class UserSettings extends Equatable {
  const UserSettings({
    required this.notifications,
    required this.privacy,
    required this.language,
    required this.inviteLink,
    required this.shareLink,
  });

  const UserSettings.empty()
      : notifications = const NotificationSettings.empty(),
        privacy = const PrivacySettings.empty(),
        language = const Language.empty(),
        inviteLink = '',
        shareLink = '';

  final NotificationSettings notifications;
  final PrivacySettings privacy;

  final Language language;
  final String inviteLink;
  final String shareLink;

  @override
  List<Object?> get props => [
        notifications,
        privacy,
        language,
        inviteLink,
        shareLink,
      ];

  UserSettings copyWith({
    NotificationSettings? notifications,
    PrivacySettings? privacy,
    Language? language,
    String? inviteLink,
    String? shareLink,
  }) {
    return UserSettings(
      notifications: notifications ?? this.notifications,
      privacy: privacy ?? this.privacy,
      language: language ?? this.language,
      inviteLink: inviteLink ?? this.inviteLink,
      shareLink: shareLink ?? this.shareLink,
    );
  }
}

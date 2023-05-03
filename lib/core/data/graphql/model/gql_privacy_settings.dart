import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';

class GqlPrivacySettings {
  GqlPrivacySettings({
    required this.directMessagesFromAccountsYouFollow,
  });

  factory GqlPrivacySettings.fromJson(Map<String, dynamic> json) => GqlPrivacySettings(
        directMessagesFromAccountsYouFollow: json["directMessagesFromAccountsYouFollow"] as bool? ?? false,
      );

  final bool directMessagesFromAccountsYouFollow;

  PrivacySettings toDomain() => PrivacySettings(
        directMessagesFromAccountsYouFollow: directMessagesFromAccountsYouFollow,
      );
}

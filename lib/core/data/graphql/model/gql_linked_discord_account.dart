import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';

class GqlLinkedDiscordAccount {
  const GqlLinkedDiscordAccount({
    required this.username,
    required this.discriminator,
    required this.profileURL,
    required this.linkedDate,
  });

  factory GqlLinkedDiscordAccount.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlLinkedDiscordAccount(
      username: asT<String>(json, 'username'),
      discriminator: asT<String>(json, 'discriminator'),
      profileURL: asT<String>(json, 'profileURL'),
      linkedDate: asT<String>(json, 'linkedDate'),
    );
  }

  final String? username;

  final String? discriminator;

  final String? profileURL;

  final String? linkedDate;

  LinkedDiscordAccount toDomain() => LinkedDiscordAccount(
        username: username ?? '',
        discriminator: discriminator ?? '',
        profileURL: profileURL ?? '',
        linkedDate: linkedDate ?? '',
      );
}

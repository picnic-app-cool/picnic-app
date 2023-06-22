import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';

class GqlLinkedRobloxAccount {
  const GqlLinkedRobloxAccount({
    required this.name,
    required this.nickname,
    required this.profileURL,
    required this.preferredUsername,
    required this.createdAt,
    required this.linkedDate,
  });

  factory GqlLinkedRobloxAccount.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlLinkedRobloxAccount(
      name: asT<String>(json, 'name'),
      nickname: asT<String>(json, 'nickname'),
      profileURL: asT<String>(json, 'profileURL'),
      preferredUsername: asT<String>(json, 'preferredUsername'),
      createdAt: asT<String>(json, 'createdAt'),
      linkedDate: asT<String>(json, 'linkedDate'),
    );
  }

  final String? name;

  final String? nickname;

  final String? preferredUsername;

  final String? createdAt;

  final String? profileURL;

  final String? linkedDate;

  LinkedRobloxAccount toDomain() => LinkedRobloxAccount(
        name: name ?? '',
        nickname: nickname ?? '',
        preferredUsername: preferredUsername ?? '',
        createdAt: createdAt ?? '',
        profileURL: profileURL ?? '',
        linkedDate: linkedDate ?? '',
      );
}

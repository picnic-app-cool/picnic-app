import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';

class LinkedSocialAccounts extends Equatable {
  const LinkedSocialAccounts({
    required this.discord,
    required this.roblox,
    required this.isDiscordLinked,
    required this.isRobloxLinked,
  });

  const LinkedSocialAccounts.empty()
      : roblox = const LinkedRobloxAccount.empty(),
        discord = const LinkedDiscordAccount.empty(),
        isDiscordLinked = false,
        isRobloxLinked = false;

  final LinkedDiscordAccount discord;
  final LinkedRobloxAccount roblox;
  final bool isDiscordLinked;
  final bool isRobloxLinked;

  bool get hasAccountsLinked => isDiscordLinked || isRobloxLinked;

  @override
  List<Object> get props => [
        discord,
        roblox,
        isDiscordLinked,
        isRobloxLinked,
      ];

  LinkedSocialAccounts copyWith({
    LinkedDiscordAccount? discord,
    LinkedRobloxAccount? roblox,
    bool? isDiscordLinked,
    bool? isRobloxLinked,
  }) {
    return LinkedSocialAccounts(
      discord: discord ?? this.discord,
      roblox: roblox ?? this.roblox,
      isDiscordLinked: isDiscordLinked ?? this.isDiscordLinked,
      isRobloxLinked: isRobloxLinked ?? this.isRobloxLinked,
    );
  }
}

import 'package:equatable/equatable.dart';

class LinkedDiscordAccount extends Equatable {
  const LinkedDiscordAccount({
    required this.username,
    required this.discriminator,
    required this.profileURL,
    required this.linkedDate,
  });

  const LinkedDiscordAccount.empty()
      : username = '',
        discriminator = '',
        profileURL = '',
        linkedDate = '';

  final String username;
  final String discriminator;
  final String profileURL;
  final String linkedDate;

  @override
  List<Object> get props => [
        username,
        discriminator,
        profileURL,
        linkedDate,
      ];

  LinkedDiscordAccount copyWith({
    String? username,
    String? discriminator,
    String? profileURL,
    String? linkedDate,
  }) {
    return LinkedDiscordAccount(
      username: username ?? this.username,
      discriminator: discriminator ?? this.discriminator,
      profileURL: profileURL ?? this.profileURL,
      linkedDate: linkedDate ?? this.linkedDate,
    );
  }
}

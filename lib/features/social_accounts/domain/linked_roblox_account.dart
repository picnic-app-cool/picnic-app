import 'package:equatable/equatable.dart';

class LinkedRobloxAccount extends Equatable {
  const LinkedRobloxAccount({
    required this.name,
    required this.nickname,
    required this.preferredUsername,
    required this.createdAt,
    required this.profileURL,
    required this.linkedDate,
  });

  const LinkedRobloxAccount.empty()
      : name = '',
        nickname = '',
        preferredUsername = '',
        createdAt = '',
        profileURL = '',
        linkedDate = '';

  final String name;
  final String nickname;
  final String preferredUsername;
  final String createdAt;
  final String profileURL;
  final String linkedDate;

  @override
  List<Object> get props => [
        name,
        nickname,
        preferredUsername,
        createdAt,
        profileURL,
        linkedDate,
      ];

  LinkedRobloxAccount copyWith({
    String? name,
    String? nickname,
    String? preferredUsername,
    String? createdAt,
    String? profileURL,
    String? linkedDate,
  }) {
    return LinkedRobloxAccount(
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      preferredUsername: preferredUsername ?? this.preferredUsername,
      createdAt: createdAt ?? this.createdAt,
      profileURL: profileURL ?? this.profileURL,
      linkedDate: linkedDate ?? this.linkedDate,
    );
  }
}

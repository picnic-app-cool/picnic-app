import 'package:equatable/equatable.dart';

class UserStats extends Equatable {
  const UserStats({
    required this.followers,
    required this.following,
  });

  const UserStats.empty()
      : followers = 0,
        following = 0;

  final int followers;
  final int following;

  @override
  List<Object> get props => [
        followers,
        following,
      ];

  UserStats copyWith({
    int? followers,
    int? following,
  }) {
    return UserStats(
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}

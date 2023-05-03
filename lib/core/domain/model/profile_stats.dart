import 'package:equatable/equatable.dart';

class ProfileStats extends Equatable {
  const ProfileStats({
    required this.likes,
    required this.views,
    required this.followers,
  });

  const ProfileStats.anonymous()
      : likes = 0,
        views = 0,
        followers = 0;

  const ProfileStats.empty() : this.anonymous();

  final int likes;
  final int views;
  final int followers;

  @override
  List<Object> get props => [
        likes,
        views,
        followers,
      ];

  ProfileStats copyWith({
    int? likes,
    int? views,
    int? followers,
  }) {
    return ProfileStats(
      likes: likes ?? this.likes,
      views: views ?? this.views,
      followers: followers ?? this.followers,
    );
  }
}

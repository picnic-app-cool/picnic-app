import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';

class GqlProfileStats {
  const GqlProfileStats({
    required this.likes,
    required this.views,
    required this.followers,
  });

  factory GqlProfileStats.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlProfileStats(
      likes: asT<int>(json, 'likes'),
      views: asT<int>(json, 'views'),
      followers: asT<int>(json, 'followers'),
    );
  }

  final int likes;
  final int views;
  final int followers;

  ProfileStats toDomain() {
    return ProfileStats(
      likes: likes,
      views: views,
      followers: followers,
    );
  }
}

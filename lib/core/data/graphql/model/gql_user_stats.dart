import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/user_stats.dart';

class GqlUserStats {
  const GqlUserStats({
    required this.followers,
    required this.following,
  });

  factory GqlUserStats.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlUserStats(
      followers: asT<int>(json, 'followers'),
      following: asT<int>(json, 'following'),
    );
  }

  final int followers;
  final int following;

  UserStats toDomain() {
    return UserStats(
      followers: followers,
      following: following,
    );
  }
}

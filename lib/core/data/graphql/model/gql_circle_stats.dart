import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';

class GqlCircleStats {
  const GqlCircleStats({
    required this.likes,
    required this.views,
    required this.posts,
    required this.members,
  });

  factory GqlCircleStats.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlCircleStats(
      likes: asT<int>(json, 'likes'),
      views: asT<int>(json, 'views'),
      posts: asT<int>(json, 'posts'),
      members: asT<int>(json, 'members'),
    );
  }

  final int likes;
  final int views;
  final int posts;
  final int members;

  CircleStats toDomain() {
    return CircleStats(
      likesCount: likes,
      viewsCount: views,
      postsCount: posts,
      membersCount: members,
    );
  }
}

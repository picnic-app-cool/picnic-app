import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';
import 'package:picnic_app/ui/widgets/picnic_vertical_post_builder.dart';

class PicnicDiscoveryTrendingPosts extends StatelessWidget {
  const PicnicDiscoveryTrendingPosts({
    Key? key,
    required this.trendingPosts,
    required this.onTapView,
    this.onTapAvatar,
  }) : super(key: key);

  final List<Post> trendingPosts;
  final ValueChanged<Post> onTapView;
  final ValueChanged<Id>? onTapAvatar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PicnicPost.verticalHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final post = trendingPosts[index];

          return SizedBox(
            width: PicnicPost.verticalWidth,
            child: PicnicVerticalPostBuilder(
              post: post,
              onTapView: onTapView,
              onTapAvatar: onTapAvatar,
              hideAuthorAvatar: false,
            ),
          );
        },
        itemCount: trendingPosts.length,
        padding: const EdgeInsets.symmetric(horizontal: Constants.largePadding),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/features/posts/text_post_creation/utils/color_to_color_option.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';

class PostGridItem extends StatelessWidget {
  const PostGridItem({
    Key? key,
    required this.post,
    this.onTapCircleTag,
    this.onTapFollow,
    this.onTapAuthor,
  }) : super(key: key);

  final Post post;
  final VoidCallback? onTapCircleTag;
  final VoidCallback? onTapFollow;
  final VoidCallback? onTapAuthor;

  // TODO: Pick theme up from the [PostContent]
  static const dummyPostPictureOne =
      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*';
  static const dummyPostPictureSecond =
      "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/daytime-outdoor-shot-of-palm-springs-california-royalty-free-image-1643648031.jpg?crop=0.835xw:1.00xh;0.107xw,0&resize=980:*";

  static const _shortGridHeight = 180.0;
  static const _longGridHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    final summaryBar = PostSummaryBar(
      author: post.author,
      post: post,
      overlayTheme: PostOverlayTheme.light,
      onTapTag: onTapCircleTag,
      padding: EdgeInsets.zero,
      showTagBackground: true,
      displayTag: false,
      isDense: true,
      showTagPrefixIcon: false,
      onToggleFollow: onTapFollow,
      onTapAuthor: onTapAuthor,
    );
    switch (post.type) {
      case PostType.text:
        return PicnicPost(
          dimension: PicnicPostDimension.vertical,
          postSummaryBar: summaryBar,
          background: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.largePadding),
            gradient: colorToColorOption(TextPostColor.green),
          ),
          bodyText: (post.content as TextPostContent).text,
          post: post,
        );
      case PostType.image:
        return PicnicPost(
          height: _shortGridHeight,
          postSummaryBar: summaryBar,
          dimension: PicnicPostDimension.vertical,
          background: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.largePadding),
            image: const DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                dummyPostPictureOne,
              ),
            ),
          ),
          post: post,
        );
      case PostType.video:
        return PicnicPost(
          height: _shortGridHeight,
          postSummaryBar: summaryBar,
          dimension: PicnicPostDimension.vertical,
          background: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.largePadding),
            image: const DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                dummyPostPictureOne,
              ),
            ),
          ),
          title: post.title,
          post: post,
        );
      case PostType.link:
        return PicnicPost(
          height: _longGridHeight,
          postSummaryBar: summaryBar,
          dimension: PicnicPostDimension.vertical,
          background: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.largePadding),
            image: const DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                dummyPostPictureOne,
              ),
            ),
          ),
          title: post.title,
          subTitle: (post.content as LinkPostContent).linkUrl.url,
          post: post,
        );
      case PostType.poll:
        return PicnicPost(
          height: _shortGridHeight,
          postSummaryBar: summaryBar,
          dimension: PicnicPostDimension.verticalGallery,
          backgroundRightHalf: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                Constants.largePadding,
              ),
              bottomRight: Radius.circular(
                Constants.largePadding,
              ),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                dummyPostPictureSecond,
              ),
            ),
          ),
          background: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Constants.largePadding,
              ),
              bottomLeft: Radius.circular(
                Constants.largePadding,
              ),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                dummyPostPictureOne,
              ),
            ),
          ),
          bodyText: post.title,
          post: post,
        );
      case PostType.unknown:
        return const SizedBox.shrink();
    }
  }
}

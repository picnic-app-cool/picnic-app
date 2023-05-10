import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';

import 'package:picnic_app/resources/assets.gen.dart';

class HorizontalPostBarButtons extends StatelessWidget {
  const HorizontalPostBarButtons({
    required this.likeButtonParams,
    required this.commentsButtonParams,
    required this.shareButtonParams,
    required this.bookmarkButtonParams,
    required this.bookmarkEnabled,
    required this.dislikeButtonParams,
    this.padding,
    super.key,
  });

  final PostBarLikeButtonParams likeButtonParams;
  final PostBarButtonParams commentsButtonParams;
  final PostBarButtonParams shareButtonParams;
  final PostBarButtonParams bookmarkButtonParams;
  final PostBarButtonParams dislikeButtonParams;
  final bool bookmarkEnabled;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    const images = Assets.images;
    final bookmarkCheckedPath = images.bookmarkChecked.path;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostBarLikeButton(
                params: PostBarLikeButtonParams(
                  isLiked: likeButtonParams.isLiked,
                  likes: likeButtonParams.likes,
                  overlayTheme: likeButtonParams.overlayTheme,
                  onTap: likeButtonParams.onTap,
                  isVertical: likeButtonParams.isVertical,
                ),
              ),
              const Gap(2),
              PostBarButton(
                params: PostBarButtonParams(
                  filledIcon: images.dislikeFilled.path,
                  outlinedIcon: images.dislikeOutlined.path,
                  onTap: dislikeButtonParams.onTap,
                  overlayTheme: dislikeButtonParams.overlayTheme,
                  isVertical: dislikeButtonParams.isVertical,
                  selected: dislikeButtonParams.selected,
                ),
              ),
            ],
          ),
          PostBarButton(
            params: PostBarButtonParams(
              filledIcon: images.chat.path,
              outlinedIcon: images.chatOutlined.path,
              onTap: commentsButtonParams.onTap,
              text: commentsButtonParams.text.toString(),
              overlayTheme: commentsButtonParams.overlayTheme,
              isVertical: commentsButtonParams.isVertical,
            ),
          ),
          PostBarButton(
            params: PostBarButtonParams(
              overlayTheme: shareButtonParams.overlayTheme,
              text: shareButtonParams.text.toString(),
              filledIcon: images.send.path,
              lightIconColor: Colors.transparent,
              outlinedIcon: images.sendOutlined.path,
              onTap: shareButtonParams.onTap,
              isVertical: shareButtonParams.isVertical,
            ),
          ),
          if (bookmarkEnabled)
            PostBarButton(
              params: PostBarButtonParams(
                text: bookmarkButtonParams.text.toString(),
                overlayTheme: bookmarkButtonParams.overlayTheme,
                filledIcon: bookmarkButtonParams.selected ? bookmarkCheckedPath : images.bookmark.path,
                lightIconColor: Colors.transparent,
                outlinedIcon: bookmarkButtonParams.selected ? bookmarkCheckedPath : images.bookmarkOutlined.path,
                onTap: bookmarkButtonParams.onTap,
                isVertical: bookmarkButtonParams.isVertical,
              ),
            ),
        ],
      ),
    );
  }
}

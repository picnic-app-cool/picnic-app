import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';

import 'package:picnic_app/resources/assets.gen.dart';

class PostBarButtons extends StatelessWidget {
  const PostBarButtons({
    required this.likeButtonParams,
    required this.commentsButtonParams,
    required this.shareButtonParams,
    required this.bookmarkButtonParams,
    required this.bookmarkEnabled,
    this.spacing,
    this.padding,
    super.key,
  });

  final PostBarLikeButtonParams likeButtonParams;
  final PostBarButtonParams commentsButtonParams;
  final PostBarButtonParams shareButtonParams;
  final PostBarButtonParams bookmarkButtonParams;
  final bool bookmarkEnabled;
  final Gap? spacing;
  final EdgeInsetsGeometry? padding;

  static const _width = 80.0;

  @override
  Widget build(BuildContext context) {
    const images = Assets.images;
    final bookmarkCheckedPath = images.bookmarkChecked.path;
    final hasSpacing = spacing != null;
    final buttonWidth = hasSpacing ? null : _width;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: hasSpacing ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          PostBarLikeButton(
            params: PostBarLikeButtonParams(
              isLiked: likeButtonParams.isLiked,
              likes: likeButtonParams.likes,
              overlayTheme: likeButtonParams.overlayTheme,
              onTap: likeButtonParams.onTap,
              isVertical: likeButtonParams.isVertical,
              width: buttonWidth,
            ),
          ),
          if (hasSpacing) spacing!,
          PostBarButton(
            params: PostBarButtonParams(
              filledIcon: images.chat.path,
              outlinedIcon: images.chatOutlined.path,
              onTap: commentsButtonParams.onTap,
              lightIconColor: Colors.transparent,
              text: commentsButtonParams.text.toString(),
              overlayTheme: commentsButtonParams.overlayTheme,
              isVertical: commentsButtonParams.isVertical,
              width: buttonWidth,
            ),
          ),
          if (hasSpacing) spacing!,
          PostBarButton(
            params: PostBarButtonParams(
              overlayTheme: shareButtonParams.overlayTheme,
              text: shareButtonParams.text.toString(),
              filledIcon: images.send.path,
              lightIconColor: Colors.transparent,
              outlinedIcon: images.sendOutlined.path,
              onTap: shareButtonParams.onTap,
              isVertical: shareButtonParams.isVertical,
              width: buttonWidth,
            ),
          ),
          if (hasSpacing) spacing!,
          if (bookmarkEnabled)
            PostBarButton(
              params: PostBarButtonParams(
                text: bookmarkButtonParams.text.toString(),
                overlayTheme: bookmarkButtonParams.overlayTheme,
                filledIcon: bookmarkButtonParams.selected ? bookmarkCheckedPath : images.bookmark.path,
                lightIconColor: Colors.transparent,
                outlinedIcon: bookmarkButtonParams.selected
                    ? bookmarkCheckedPath
                    : spacing != null
                        ? images.bookmarkOutlined.path
                        : images.bookmarkOutlinedMedium.path,
                onTap: bookmarkButtonParams.onTap,
                isVertical: bookmarkButtonParams.isVertical,
                width: buttonWidth,
              ),
            ),
        ],
      ),
    );
  }
}

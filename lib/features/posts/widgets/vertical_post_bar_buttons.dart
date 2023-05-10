import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';

import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VerticalPostBarButtons extends StatelessWidget {
  const VerticalPostBarButtons({
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
    final buttonsDropShadow = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: PicnicTheme.of(context).colors.blackAndWhite.shade600.withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 2),
        ),
      ],
    );
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostBarLikeButton(
                decoration: buttonsDropShadow,
                params: PostBarLikeButtonParams(
                  isLiked: likeButtonParams.isLiked,
                  likes: likeButtonParams.likes,
                  overlayTheme: likeButtonParams.overlayTheme,
                  onTap: likeButtonParams.onTap,
                  isVertical: likeButtonParams.isVertical,
                ),
              ),
              PostBarButton(
                decoration: buttonsDropShadow,
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
          const Gap(24),
          PostBarButton(
            decoration: buttonsDropShadow,
            params: PostBarButtonParams(
              filledIcon: images.chat.path,
              outlinedIcon: images.chatOutlined.path,
              onTap: commentsButtonParams.onTap,
              text: commentsButtonParams.text.toString(),
              overlayTheme: commentsButtonParams.overlayTheme,
              isVertical: commentsButtonParams.isVertical,
            ),
          ),
          const Gap(24),
          PostBarButton(
            decoration: buttonsDropShadow,
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
          const Gap(24),
          if (bookmarkEnabled)
            PostBarButton(
              decoration: buttonsDropShadow,
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

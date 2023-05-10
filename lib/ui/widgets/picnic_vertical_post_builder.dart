import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/text_post_creation/utils/color_to_color_option.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_post.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

class PicnicVerticalPostBuilder extends StatelessWidget {
  const PicnicVerticalPostBuilder({
    super.key,
    required this.post,
    required this.onTapView,
    this.onLongPressViewActions,
    required this.hideAuthorAvatar,
    this.onTapAvatar,
    this.padding,
    this.footerText,
    this.isMultiSelectionEnabled,
    this.isSelected,
    this.onTapSelectedView,
  });

  final Post post;
  final Function(Post) onTapView;
  final VoidCallback? onLongPressViewActions;

  final Function(Id)? onTapAvatar;
  final bool hideAuthorAvatar;
  final EdgeInsetsGeometry? padding;
  final String? footerText;
  final bool? isMultiSelectionEnabled;
  final bool? isSelected;
  final Function(Post)? onTapSelectedView;

  @override
  Widget build(BuildContext context) {
    final footer = footerText ?? post.author.username.formattedUsername;

    return post.content.when(
      textPostContent: (TextPostContent content) {
        return PicnicVerticalPost.text(
          footer: footer,
          onTapView: () => onTapView(post),
          views: post.contentStats.impressions,
          text: content.text,
          gradient: colorToColorOption(content.color),
          hideAuthorAvatar: hideAuthorAvatar,
          avatarUrl: post.author.profileImageUrl,
          onTapAvatar: () => onTapAvatar?.call(post.author.id),
          isSelected: isSelected,
          onTapSelectedView: () => onTapSelectedView?.call(post),
          isMultiSelectionEnabled: isMultiSelectionEnabled,
          padding: padding,
        );
      },
      imagePostContent: (ImagePostContent content) {
        return PicnicVerticalPost.image(
          footer: footer,
          onTapView: () => onTapView(post),
          views: post.contentStats.impressions,
          imageUrl: content.imageUrl,
          hideAuthorAvatar: hideAuthorAvatar,
          avatarUrl: post.author.profileImageUrl,
          onTapAvatar: () => onTapAvatar?.call(post.author.id),
          isSelected: isSelected,
          onTapSelectedView: () => onTapSelectedView?.call(post),
          isMultiSelectionEnabled: isMultiSelectionEnabled,
          padding: padding,
        );
      },
      videoPostContent: (VideoPostContent content) {
        return PicnicVerticalPost.video(
          footer: footer,
          onTapView: () => onTapView(post),
          views: post.contentStats.impressions,
          imageUrl: content.thumbnailUrl,
          hideAuthorAvatar: hideAuthorAvatar,
          avatarUrl: post.author.profileImageUrl,
          onTapAvatar: () => onTapAvatar?.call(post.author.id),
          isSelected: isSelected,
          onTapSelectedView: () => onTapSelectedView?.call(post),
          isMultiSelectionEnabled: isMultiSelectionEnabled,
          padding: padding,
        );
      },
      linkPostContent: (LinkPostContent content) {
        return PicnicVerticalPost.link(
          footer: footer,
          onTapView: () => onTapView(post),
          views: post.contentStats.impressions,
          link: content.linkUrl,
          linkMetadata: content.metadata,
          hideAuthorAvatar: hideAuthorAvatar,
          avatarUrl: post.author.profileImageUrl,
          onTapAvatar: () => onTapAvatar?.call(post.author.id),
          isSelected: isSelected,
          onTapSelectedView: () => onTapSelectedView?.call(post),
          isMultiSelectionEnabled: isMultiSelectionEnabled,
          padding: padding,
        );
      },
      pollPostContent: (PollPostContent content) {
        return PicnicVerticalPost.poll(
          footer: footer,
          onTapView: () => onTapView(post),
          views: post.contentStats.impressions,
          hideAuthorAvatar: hideAuthorAvatar,
          avatarUrl: post.author.profileImageUrl,
          onTapAvatar: () => onTapAvatar?.call(post.author.id),
          isSelected: isSelected,
          onTapSelectedView: () => onTapSelectedView?.call(post),
          isMultiSelectionEnabled: isMultiSelectionEnabled,
          padding: padding,
          leftImageUrl: content.leftPollAnswer.imageUrl,
          rightImageUrl: content.rightPollAnswer.imageUrl,
        );
      },
      unknownContent: () => const SizedBox.shrink(),
    );
  }
}

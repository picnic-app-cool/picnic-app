import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/image_post_preview.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/link_post_preview.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/poll_post_preview.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/text_post_preview.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/video_post_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';

typedef PostPreviewOnVotedCallback = void Function(PicnicPollVote);
typedef PostPreviewOnLinkTapCallback = void Function(LinkUrl);

class FeedPostPreviewInComments extends StatelessWidget {
  const FeedPostPreviewInComments({
    Key? key,
    required this.post,
    required this.user,
    this.onVoted,
    this.onTapLink,
    this.isPolling = false,
    this.vote,
  }) : super(key: key);

  final Post post;
  final PrivateProfile user;
  final PostPreviewOnVotedCallback? onVoted;
  final PostPreviewOnLinkTapCallback? onTapLink;
  final PicnicPollVote? vote;
  final bool isPolling;

  @override
  Widget build(BuildContext context) {
    // TODO: Use `when` function from the PostContent class
    switch (post.type) {
      case PostType.link:
        final linkContent = post.content as LinkPostContent;
        return LinkPostPreview(
          linkUrl: linkContent.linkUrl,
          linkMetadata: linkContent.metadata,
          onTapLink: (link) => onTapLink?.call(link),
        );
      case PostType.image:
        final imageContent = post.content as ImagePostContent;
        return ImagePostPreview(imageUrl: imageContent.imageUrl);
      case PostType.text:
        final textContent = post.content as TextPostContent;
        return TextPostPreview(
          text: textContent.text,
        );
      case PostType.poll:
        return PollPostPreview(
          post: post,
          onVoted: (vote) => onVoted?.call(vote),
          user: user,
          isPolling: isPolling,
          vote: vote,
        );
      case PostType.unknown:
        return const SizedBox.shrink();
      case PostType.video:
        final videoContent = post.content as VideoPostContent;
        return VideoPostPreview(
          videoUrl: videoContent.videoUrl,
          thumbnailUrl: videoContent.thumbnailUrl,
        );
    }
  }
}

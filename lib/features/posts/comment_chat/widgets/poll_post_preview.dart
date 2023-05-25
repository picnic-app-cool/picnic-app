import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';

class PollPostPreview extends StatelessWidget {
  const PollPostPreview({
    Key? key,
    required this.onVoted,
    required this.post,
    required this.user,
    this.isPolling = false,
    this.vote,
  }) : super(key: key);

  final Function(PicnicPollVote) onVoted;
  final Post post;
  final PrivateProfile user;
  final PicnicPollVote? vote;
  final bool isPolling;

  static const radius = 5.0;

  @override
  Widget build(BuildContext context) {
    final postHeight = MediaQuery.of(context).size.height / 2.4;
    final content = post.content as PollPostContent;

    return SizedBox(
      height: postHeight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: PicnicPollPost(
            onVote: onVoted,
            leftImage: content.leftPollAnswer.imageUrl,
            rightImage: content.rightPollAnswer.imageUrl,
            userImageUrl: user.profileImageUrl,
            leftVotes: content.leftVotesPercentage,
            rightVotes: content.rightVotesPercentage,
            vote: vote,
            isLoading: isPolling,
          ),
        ),
      ),
    );
  }
}

import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PollPostPresentationModel implements PollPostViewModel {
  /// Creates the initial state
  PollPostPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PollPostInitialParams initialParams,
  )   : comments = const [],
        post = initialParams.post,
        user = const PrivateProfile.empty(),
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportId = initialParams.reportId,
        displayOptions = PostDisplayOptions(
          showTimestamp: initialParams.showTimestamp,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: false,
          detailsMode: initialParams.mode,
          overlaySize: initialParams.overlaySize,
          commentsMode: CommentsMode.none,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        );

  /// Used for the copyWith method
  PollPostPresentationModel._({
    required this.post,
    required this.comments,
    required this.user,
    required this.onPostUpdatedCallback,
    required this.reportId,
    required this.displayOptions,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final Id reportId;

  @override
  final List<CommentPreview> comments;

  @override
  final Post post;

  @override
  final PrivateProfile user;

  @override
  final PostDisplayOptions displayOptions;

  @override
  PicnicPollVote? get vote => pollContent.votedAnswerId.isNone
      ? null
      : (pollContent.votedAnswerId == pollContent.rightPollAnswer.id ? PicnicPollVote.right : PicnicPollVote.left);

  @override
  PollPostContent get pollContent => post.content as PollPostContent;

  @override
  BasicPublicProfile get author => post.author;

  @override
  bool get showReportAction => displayOptions.detailsMode == PostDetailsMode.report;

  PollPostPresentationModel byUpdatingPostVotedAnswer({required Id answerId}) {
    final updatedAnswers = pollContent.answers.map((it) {
      var updatedAnswer = it;
      if (it.id == answerId) {
        updatedAnswer = it.copyWith(votesCount: it.votesCount + 1);
      }
      return updatedAnswer;
    }).toList();

    return copyWith(
      post: post.copyWith(
        content: pollContent.copyWith(
          answers: updatedAnswers,
          votesTotal: pollContent.votesTotal + 1,
          votedAnswerId: answerId,
        ),
      ),
    );
  }

  PollPostPresentationModel byUpdatingPostContent({required PollPostContent pollContent}) => copyWith(
        post: post.copyWith(
          content: post.content,
        ),
      );

  PollPostPresentationModel copyWith({
    Function(Post)? onPostUpdatedCallback,
    Id? reportId,
    List<CommentPreview>? comments,
    Post? post,
    PrivateProfile? user,
    PostDisplayOptions? displayOptions,
  }) {
    return PollPostPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      reportId: reportId ?? this.reportId,
      comments: comments ?? this.comments,
      post: post ?? this.post,
      user: user ?? this.user,
      displayOptions: displayOptions ?? this.displayOptions,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PollPostViewModel {
  List<CommentPreview> get comments;

  Post get post;

  Id get reportId;

  BasicPublicProfile get author;

  bool get showReportAction;

  PollPostContent get pollContent;

  PicnicPollVote? get vote;

  PrivateProfile get user;

  PostDisplayOptions get displayOptions;
}

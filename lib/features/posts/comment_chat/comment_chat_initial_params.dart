import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class CommentChatInitialParams {
  const CommentChatInitialParams({
    required this.post,
    this.onPostUpdated,
    this.reportedComment,
    this.reportId = const Id.empty(),
    this.showAppBar = true,
    this.showPostPreview = true,
    this.shouldBeDisposed = true,
    this.nestedComment = const TreeComment.empty(),
    this.initialComment = const TreeComment.empty(),
  });

  final Post post;
  final Function(Post)? onPostUpdated;
  final TreeComment? reportedComment;
  final Id reportId;
  final bool showAppBar;
  final bool showPostPreview;
  final bool shouldBeDisposed;
  final TreeComment nestedComment;
  final TreeComment initialComment;
}

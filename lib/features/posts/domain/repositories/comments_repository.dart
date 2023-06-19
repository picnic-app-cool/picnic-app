import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/create_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/delete_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comment_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_preview_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_pinned_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/pin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/model/unpin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_comment_failure.dart';

abstract class CommentsRepository {
  Future<Either<LikeUnlikeCommentFailure, Unit>> likeDislikeComment({
    required Id commentId,
    required LikeDislikeReaction likeDislikeReaction,
  });

  Future<Either<UnreactToCommentFailure, Unit>> unReactToComment({
    required Id commentId,
  });

  Future<Either<GetCommentsFailure, TreeComment>> getComments({
    required Post post,
    Id parentCommentId,
    int depthLevel,
    Cursor cursor,
  });

  Future<Either<GetCommentsPreviewFailure, List<CommentPreview>>> getCommentsPreview({
    required Id postId,
    int count,
  });

  Future<Either<CreateCommentFailure, TreeComment>> createComment({
    required Id postId,
    required Id postAuthorId,
    required String text,
    Id parentCommentId,
  });

  Future<Either<DeleteCommentFailure, Unit>> deleteComment({
    required Id commentId,
  });

  Future<Either<GetPinnedCommentsFailure, List<TreeComment>>> getPinnedComments({
    required Post post,
  });

  Future<Either<PinCommentFailure, Unit>> pinComment({
    required Id commentId,
  });

  Future<Either<UnpinCommentFailure, Unit>> unpinComment({
    required Id commentId,
  });

  Future<Either<GetCommentByIdFailure, TreeComment>> getCommentById({
    required Id commentId,
  });
}

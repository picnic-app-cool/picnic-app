import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class GetCommentsUseCase {
  const GetCommentsUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<GetCommentsFailure, TreeComment>> execute({
    required Post post,
    Id parentCommentId = const Id.none(),
    Cursor cursor = const Cursor.firstPage(
      pageSize: Cursor.extendedPageSize,
    ),
  }) async {
    return _commentsRepository.getComments(
      post: post,
      parentCommentId: parentCommentId,
      cursor: cursor,
    );
  }
}

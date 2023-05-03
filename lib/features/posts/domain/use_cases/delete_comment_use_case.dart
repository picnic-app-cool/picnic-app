import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/delete_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class DeleteCommentUseCase {
  const DeleteCommentUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<DeleteCommentFailure, Unit>> execute({
    required Id commentId,
  }) async {
    return _commentsRepository.deleteComment(commentId: commentId);
  }
}

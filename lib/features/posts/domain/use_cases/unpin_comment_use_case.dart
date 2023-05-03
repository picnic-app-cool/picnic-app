import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/unpin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class UnpinCommentUseCase {
  const UnpinCommentUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<UnpinCommentFailure, Unit>> execute({
    required Id commentId,
  }) async {
    return _commentsRepository.unpinComment(commentId: commentId);
  }
}

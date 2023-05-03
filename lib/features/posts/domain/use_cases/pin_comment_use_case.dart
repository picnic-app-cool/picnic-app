import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/pin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class PinCommentUseCase {
  const PinCommentUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<PinCommentFailure, Unit>> execute({
    required Id commentId,
  }) async {
    return _commentsRepository.pinComment(commentId: commentId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class LikeUnlikeCommentUseCase {
  const LikeUnlikeCommentUseCase(
    this._commentsRepository,
    this._hapticFeedbackUseCase,
  );

  final CommentsRepository _commentsRepository;
  final HapticFeedbackUseCase _hapticFeedbackUseCase;

  Future<Either<LikeUnlikeCommentFailure, Unit>> execute({
    required Id commentId,
    required bool like,
  }) {
    return _commentsRepository
        .likeUnlikeComment(commentId: commentId, like: like) //
        .doOn(success: (_) => _hapticFeedbackUseCase.execute());
  }
}

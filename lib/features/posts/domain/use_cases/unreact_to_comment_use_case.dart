import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class UnreactToCommentUseCase {
  const UnreactToCommentUseCase(
    this._commentsRepository,
    this._hapticFeedbackUseCase,
  );

  final CommentsRepository _commentsRepository;
  final HapticFeedbackUseCase _hapticFeedbackUseCase;

  Future<Either<UnreactToCommentFailure, Unit>> execute(Id commentId) {
    return _commentsRepository
        .unReactToComment(commentId: commentId)
        .doOn(success: (_) => _hapticFeedbackUseCase.execute());
  }
}

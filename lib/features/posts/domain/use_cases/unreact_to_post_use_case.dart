import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_post_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class UnreactToPostUseCase {
  const UnreactToPostUseCase(
    this._postsRepository,
    this._hapticFeedbackUseCase,
  );

  final PostsRepository _postsRepository;
  final HapticFeedbackUseCase _hapticFeedbackUseCase;

  Future<Either<UnreactToPostFailure, Post>> execute({required Id postId}) => _postsRepository
      .unReactToPost(postId: postId)
      .flatMap(
        (_) => _postsRepository.getPostById(id: postId).mapFailure(
              UnreactToPostFailure.unknown,
            ),
      )
      .doOn(success: (_) => _hapticFeedbackUseCase.execute());
}

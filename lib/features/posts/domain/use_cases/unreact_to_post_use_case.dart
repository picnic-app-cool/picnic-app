import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_post_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';

class UnreactToPostUseCase {
  const UnreactToPostUseCase(
    this._postsRepository,
    this._hapticFeedbackUseCase,
    this._getPostUseCase,
  );

  final PostsRepository _postsRepository;
  final HapticFeedbackUseCase _hapticFeedbackUseCase;
  final GetPostUseCase _getPostUseCase;

  Future<Either<UnreactToPostFailure, Post>> execute({required Id postId}) => _postsRepository
      .unReactToPost(postId: postId)
      .flatMap(
        (_) => _getPostUseCase.execute(postId: postId).mapFailure(
              UnreactToPostFailure.unknown,
            ),
      )
      .doOn(success: (_) => _hapticFeedbackUseCase.execute());
}

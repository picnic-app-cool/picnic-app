import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class LikeUnlikePostUseCase {
  const LikeUnlikePostUseCase(
    this._postsRepository,
    this._hapticFeedbackUseCase,
  );

  final PostsRepository _postsRepository;
  final HapticFeedbackUseCase _hapticFeedbackUseCase;

  Future<Either<LikeUnlikePostFailure, Post>> execute({
    required Id id,
    required bool like,
  }) =>
      _postsRepository
          .likeUnlikePost(id: id, like: like)
          .flatMap(
            (_) => _postsRepository.getPostById(id: id).mapFailure(
                  LikeUnlikePostFailure.unknown,
                ),
          )
          .doOn(success: (_) => _hapticFeedbackUseCase.execute());
}

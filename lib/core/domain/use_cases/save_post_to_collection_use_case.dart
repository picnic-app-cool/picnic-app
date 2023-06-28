import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';

class SavePostToCollectionUseCase {
  const SavePostToCollectionUseCase(
    this._postsRepository,
    this._getPostUseCase,
  );

  final PostsRepository _postsRepository;
  final GetPostUseCase _getPostUseCase;

  Future<Either<SavePostToCollectionFailure, Post>> execute({
    required SavePostInput input,
  }) async {
    return _postsRepository
        .updatePostCollectionStatus(input: input)
        .mapFailure(
          SavePostToCollectionFailure.unknown,
        )
        .flatMap(
          (_) => _getPostUseCase.execute(postId: input.postId).mapFailure(
                SavePostToCollectionFailure.unknown,
              ),
        );
  }
}

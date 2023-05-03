import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/delete_posts_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class DeletePostsUseCase {
  const DeletePostsUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<DeletePostsFailure, Unit>> execute({required List<Id> postIds}) =>
      _postsRepository.deletePosts(postIds: postIds);
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class GetPostUseCase {
  const GetPostUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<GetPostByIdFailure, Post>> execute({
    required Id postId,
  }) {
    return _postsRepository.getPostById(id: postId);
  }
}

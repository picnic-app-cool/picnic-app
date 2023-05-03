import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class ViewPostUseCase {
  const ViewPostUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<ViewPostFailure, Unit>> execute({required Id postId}) {
    return _postsRepository.viewPost(postId: postId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/share_post_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class SharePostUseCase {
  const SharePostUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<SharePostFailure, Unit>> execute({required Id postId}) async {
    return _postsRepository.sharePost(postId: postId);
  }
}

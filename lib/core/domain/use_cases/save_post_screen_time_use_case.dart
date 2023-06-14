import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_screen_time_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class SavePostScreenTimeUseCase {
  const SavePostScreenTimeUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<SavePostScreenTimeFailure, Unit>> execute({
    required Id postId,
    required int duration,
  }) {
    return _postsRepository.savePostScreenTime(
      postId: postId,
      duration: duration,
    );
  }
}

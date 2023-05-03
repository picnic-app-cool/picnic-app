import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class CreatePostUseCase {
  const CreatePostUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<void> execute({
    required CreatePostInput createPostInput,
  }) async {
    return _postsRepository.createPostInBackground(createPostInput: createPostInput);
  }
}

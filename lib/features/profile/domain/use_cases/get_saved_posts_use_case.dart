import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/repositories/saved_posts_repository.dart';

class GetSavedPostsUseCase {
  const GetSavedPostsUseCase(
    this._savedPostsRepository,
  );

  final SavedPostsRepository _savedPostsRepository;

  Future<Either<GetSavedPostsFailure, PaginatedList<Post>>> execute({
    required Cursor nextPageCursor,
  }) =>
      _savedPostsRepository.getSavedPosts(nextPageCursor: nextPageCursor);
}

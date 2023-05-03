import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_sorted_posts_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_posts_repository.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GetCircleSortedPostsUseCase {
  const GetCircleSortedPostsUseCase(this._circlePostsRepository);

  final CirclePostsRepository _circlePostsRepository;

  Future<Either<GetCircleSortedPostsFailure, PaginatedList<Post>>> execute({
    required Id circleId,
    required Cursor nextPageCursor,
    required PostsSortingType sortingType,
  }) async =>
      _circlePostsRepository.getCircleSortedPosts(
        circleId: circleId,
        nextPageCursor: nextPageCursor,
        sortingType: sortingType,
      );
}

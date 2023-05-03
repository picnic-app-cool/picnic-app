import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_sorted_posts_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_sorting_option_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

abstract class CirclePostsRepository {
  Future<Either<GetCircleSortedPostsFailure, PaginatedList<Post>>> getCircleSortedPosts({
    required Id circleId,
    required Cursor nextPageCursor,
    required PostsSortingType sortingType,
  });

  Future<Either<GetLastUsedSortingOptionFailure, PostsSortingType>> getLastUsedSortingOption({
    required Id circleId,
  });
}

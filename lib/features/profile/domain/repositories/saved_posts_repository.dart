import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';

abstract class SavedPostsRepository {
  //TODO: https://picnic-app.atlassian.net/browse/GS-2381 : BE Integration - Saved posts - add userId as param
  Future<Either<GetSavedPostsFailure, PaginatedList<Post>>> getSavedPosts({
    required Cursor nextPageCursor,
  });
}

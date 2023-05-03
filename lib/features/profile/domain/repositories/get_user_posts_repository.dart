import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';

abstract class GetUserPostsRepository {
  Future<Either<GetUserPostsFailure, PaginatedList<Post>>> getUserPosts({
    required Id userId,
    required Cursor nextPageCursor,
  });
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/repositories/get_user_posts_repository.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GetUserPostsUseCase with FutureRetarder {
  const GetUserPostsUseCase(
    this._getUserPostsRepository,
  );

  final GetUserPostsRepository _getUserPostsRepository;

  Future<Either<GetUserPostsFailure, PaginatedList<Post>>> execute({
    required Id userId,
    required Cursor nextPageCursor,
  }) =>
      _getUserPostsRepository.getUserPosts(
        userId: userId,
        nextPageCursor: nextPageCursor,
      );
}

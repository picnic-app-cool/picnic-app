import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cache_policy.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/delete_posts_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/share_post_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_posts_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_sounds_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';

abstract class PostsRepository {
  Stream<CacheableResult<GetPostsFailure, PaginatedList<Post>>> getFeedPosts({
    required Id feedId,
    required String searchQuery,
    required Cursor cursor,
    CachePolicy? cachePolicy,
  });

  Future<Either<GetSoundsFailure, PaginatedList<Sound>>> getSounds({
    required String searchQuery,
    required Cursor cursor,
  });

  Future<Either<CreatePostFailure, Post>> createPost({
    required CreatePostInput createPostInput,
  });

  Future<void> createPostInBackground({
    required CreatePostInput createPostInput,
  });

  /// saves given post to collection and returns updated saved status
  Future<Either<SavePostToCollectionFailure, bool>> updatePostCollectionStatus({
    required SavePostInput input,
  });

  ///
  Future<Either<VoteInPollFailure, Id>> voteInPoll({
    required VoteInPollInput voteInPollInput,
  });

  ///
  Future<Either<DeletePostsFailure, Unit>> deletePosts({
    required List<Id> postIds,
  });

  ///
  Future<Either<ViewPostFailure, Unit>> viewPost({
    required Id postId,
  });

  /// Since [Post] now has `isLiked` variable, we don't need to pass a separate parameter stating whether the user
  /// liked/unliked the post
  Future<Either<LikeUnlikePostFailure, bool>> likeUnlikePost({
    required Id id,
    required bool like,
  });

  Future<Either<GetLinkMetadataFailure, LinkMetadata>> getLinkMetadata({
    required String link,
  });

  Future<Either<GetPostByIdFailure, Post>> getPostById({
    required Id id,
  });

  Future<Either<SharePostFailure, Unit>> sharePost({required Id postId});
}

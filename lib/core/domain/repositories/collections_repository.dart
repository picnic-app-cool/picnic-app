import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/add_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';
import 'package:picnic_app/features/profile/domain/model/delete_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart';

import 'package:picnic_app/features/profile/domain/model/remove_collection_posts_failure.dart';

abstract class CollectionsRepository {
  Future<Either<GetCollectionsFailure, PaginatedList<Collection>>> getCollections({
    required Id userId,
    required Cursor nextPageCursor,
    bool withPreviewPosts = true,
    bool returnSavedPostsCollection = true,
  });

  Future<Either<GetPostsInCollectionFailure, PaginatedList<Post>>> getPostsInCollection({
    required Id collectionId,
    required Cursor nextPageCursor,
  });

  Future<Either<RemoveCollectionPostsFailure, Unit>> deletePostsFromCollection({
    required List<Id> postIds,
    required Id collectionId,
  });

  Future<Either<DeleteCollectionFailure, Unit>> deleteCollection({required Id collectionId});

  Future<Either<AddPostToCollectionFailure, Unit>> addPostToCollection({
    required Id postId,
    required Id collectionId,
  });

  Future<Either<CreateCollectionFailure, Collection>> createCollection({
    required CreateCollectionInput createCollectionInput,
  });
}

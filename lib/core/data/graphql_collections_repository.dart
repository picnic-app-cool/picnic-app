import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/collection_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/collection/gql_collection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/domain/model/add_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/data/model/gql_create_collection_input.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';
import 'package:picnic_app/features/profile/domain/model/delete_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/remove_collection_posts_failure.dart';

class GraphqlCollectionsRepository implements CollectionsRepository {
  const GraphqlCollectionsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetCollectionsFailure, PaginatedList<Collection>>> getCollections({
    required Id userId,
    required Cursor nextPageCursor,
    bool withPreviewPosts = true,
    bool returnSavedPostsCollection = true,
  }) async {
    return _gqlClient
        .query(
          document: getCollectionsQuery,
          variables: {
            'userId': userId.value,
            'cursor': nextPageCursor.toGqlCursorInput(),
            'withPreviewPosts': withPreviewPosts,
            'returnSavedPostsCollection': returnSavedPostsCollection,
          },
          parseData: (json) {
            final data = json['collectionsConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(GetCollectionsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlCollection.fromJson(node).toDomain(_userStore),
          ),
        );
  }

  @override
  Future<Either<GetPostsInCollectionFailure, PaginatedList<Post>>> getPostsInCollection({
    required Id collectionId,
    required Cursor nextPageCursor,
  }) async {
    return _gqlClient
        .query(
          document: collectionPostsQuery,
          variables: {
            'collectionId': collectionId.value,
            'cursor': nextPageCursor.toGqlCursorInput(),
          },
          parseData: (json) {
            final data = json['collectionPostsConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(GetPostsInCollectionFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlPost.fromJson(node).toDomain(_userStore),
          ),
        );
  }

  /// [unsave] sets whether to remove posts from saved posts
  @override
  Future<Either<RemoveCollectionPostsFailure, Unit>> deletePostsFromCollection({
    required List<Id> postIds,
    required Id collectionId,
    bool unsave = true,
  }) =>
      _gqlClient
          .mutate(
            document: removeCollectionPosts,
            variables: {
              'postIds': postIds.map((it) => it.value).toList(),
              'collectionId': collectionId.value,
              'unsave': unsave,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['deletePostsFromCollection'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => const RemoveCollectionPostsFailure.unknown())
          .mapSuccessPayload(onFailureReturn: const RemoveCollectionPostsFailure.unknown());

  @override
  Future<Either<AddPostToCollectionFailure, Unit>> addPostToCollection({
    required Id postId,
    required Id collectionId,
  }) =>
      _gqlClient
          .mutate(
            document: addPostToCollectionQuery,
            variables: {
              'postId': postId.value,
              'collectionId': collectionId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['addPostToCollection'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => const AddPostToCollectionFailure.unknown())
          .mapSuccessPayload(onFailureReturn: const AddPostToCollectionFailure.unknown());

  @override
  Future<Either<DeleteCollectionFailure, Unit>> deleteCollection({required Id collectionId}) => _gqlClient
      .mutate(
        document: deleteCollectionQuery,
        variables: {
          'collectionId': collectionId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['deleteCollection'] as Map<String, dynamic>),
      )
      .mapFailure((fail) => const DeleteCollectionFailure.unknown())
      .mapSuccessPayload(onFailureReturn: const DeleteCollectionFailure.unknown());

  @override
  Future<Either<CreateCollectionFailure, Collection>> createCollection({
    required CreateCollectionInput createCollectionInput,
  }) =>
      _gqlClient
          .mutate(
            document: createCollectionMutation,
            variables: {
              'createCollectionInput': createCollectionInput.toJson(),
            },
            parseData: (json) {
              return GqlCollection.fromJson(json['createCollection'] as Map<String, dynamic>);
            },
          )
          .mapSuccess((response) => response.toDomain(_userStore))
          .mapFailure(CreateCollectionFailure.unknown);
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/data/graphql/model/gql_link_metadata.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/graphql/model/gql_sound.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cache_policy.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/delete_posts_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/share_post_failure.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/data/model/gql_create_post_input.dart';
import 'package:picnic_app/features/posts/data/posts_queries.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_posts_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_sounds_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class GraphQlPostsRepository implements PostsRepository {
  GraphQlPostsRepository(
    this._gqlClient,
    this._userStore,
    this._backgroundApiRepository,
  );

  static const permissionDenied = 'PermissionDenied';

  final GraphQLClient _gqlClient;
  final UserStore _userStore;
  final BackgroundApiRepository _backgroundApiRepository;

  @override
  Future<Either<CreatePostFailure, Post>> createPost({
    required CreatePostInput createPostInput,
  }) {
    return _gqlClient
        .mutate(
          document: createPostMutation,
          variables: {
            'data': GqlCreatePostInput.fromDomain(createPostInput).toJson(),
          },
          parseData: (json) {
            return GqlPost.fromJson(json['createPost'] as Map<String, dynamic>);
          },
        )
        .mapSuccess((response) => response.toDomain(_userStore))
        .mapFailure(
      (fail) {
        if (fail.errorCode == permissionDenied) {
          return CreatePostFailure.permissionDenied(fail);
        }
        return fail.isFileSizeTooBig ? CreatePostFailure.fileTooBig(fail) : CreatePostFailure.unknown(fail);
      },
    );
  }

  @override
  Future<void> createPostInBackground({required CreatePostInput createPostInput}) {
    return _backgroundApiRepository.registerBackgroundCall(
      apiCall: CreatePostGraphQLBackgroundCall(
        input: createPostInput,
        gqlClient: _gqlClient,
        userStore: _userStore,
      ),
    );
  }

  @override
  Stream<CacheableResult<GetPostsFailure, PaginatedList<Post>>> getFeedPosts({
    required Id feedId,
    required String searchQuery,
    required Cursor cursor,
    CachePolicy? cachePolicy,
  }) {
    return _gqlClient
        .watchQuery(
          document: getFeedPostCollectionQuery,
          variables: {"feedId": feedId.value, "cursor": cursor.toGqlCursorInput().toJson()},
          parseData: (json) {
            final data = json['feedPostsConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
          options: const WatchQueryOptions.defaultOptions().copyWith(
            cachePolicy: cachePolicy,
          ),
        )
        .mapFailure(GetPostsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlPost.fromJson(node).toDomain(
              _userStore,
            ),
          ),
        );
  }

  @override
  Future<Either<GetSoundsFailure, PaginatedList<Sound>>> getSounds({
    required String searchQuery,
    required Cursor cursor,
  }) =>
      _gqlClient
          .query(
            document: soundsConnectionQuery,
            variables: {
              'cursor': cursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['soundsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetSoundsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlSound.fromJson(node).toDomain(),
            ),
          );

  @override
  Future<Either<LikeUnlikePostFailure, Unit>> likeUnlikePost({
    required Id id,
    required LikeDislikeReaction likeDislikeReaction,
  }) =>
      _gqlClient
          .mutate(
            document: reactPostMutation,
            variables: {
              'postId': id.value,
              'reaction': likeDislikeReaction.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['reactToPost'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => const LikeUnlikePostFailure.unknown())
          .mapSuccessPayload(onFailureReturn: const LikeUnlikePostFailure.unknown());

  @override
  Future<Either<UnreactToPostFailure, Unit>> unReactToPost({
    required Id postId,
  }) =>
      _gqlClient
          .mutate(
            document: unReactToPostMutation,
            variables: {
              'postId': postId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['unreactToPost'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => const UnreactToPostFailure.unknown())
          .mapSuccessPayload(onFailureReturn: const UnreactToPostFailure.unknown());

  @override
  Future<Either<SavePostToCollectionFailure, bool>> updatePostCollectionStatus({
    required SavePostInput input,
  }) =>
      _gqlClient
          .mutate(
            document: savePostToCollectionMutation,
            variables: {
              'postId': input.postId.value,
              'saveStatus': input.save,
            },
            parseData: (_) => unit,
          )
          .mapFailure(SavePostToCollectionFailure.unknown)
          .mapSuccess((response) => input.save);

  @override
  Future<Either<VoteInPollFailure, Id>> voteInPoll({
    required VoteInPollInput voteInPollInput,
  }) =>
      _gqlClient
          .mutate(
            document: voteInPollMutation,
            variables: {
              'postId': voteInPollInput.postId.value,
              'variantId': voteInPollInput.answerId.value,
            },
            parseData: (_) => unit,
          )
          .mapFailure(VoteInPollFailure.unknown)
          .mapSuccess((response) => voteInPollInput.answerId);

  @override
  Future<Either<GetLinkMetadataFailure, LinkMetadata>> getLinkMetadata({
    required String link,
  }) {
    return _gqlClient
        .query(
          document: getLinkMetadataQuery,
          variables: {'link': link},
          parseData: (data) {
            return GqlLinkMetadata.fromJson(asT(asT(data, 'linkMetaData'), 'data')).toDomain();
          },
        )
        .mapFailure(GetLinkMetadataFailure.unknown);
  }

  @override
  Future<Either<ViewPostFailure, Unit>> viewPost({required Id postId}) => _gqlClient
      .mutate(
        document: viewPostMutation,
        variables: {
          'postId': postId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['viewPost'] as Map<String, dynamic>),
      )
      .mapFailure(ViewPostFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const ViewPostFailure.unknown());

  @override
  Future<Either<SharePostFailure, Unit>> sharePost({required Id postId}) => _gqlClient
      .mutate(
        document: sharePostMutation,
        variables: {
          'postId': postId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['sharePost'] as Map<String, dynamic>),
      )
      .mapFailure(SharePostFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const SharePostFailure.unknown());

  @override
  Future<Either<GetPostByIdFailure, Post>> getPostById({required Id id}) {
    return _gqlClient
        .query(
          document: getPostByIdQuery,
          variables: {'postId': id.value},
          parseData: (data) {
            return GqlPost.fromJson(data['getPost'] as Map<String, dynamic>);
          },
        )
        .mapSuccess((response) => response.toDomain(_userStore))
        .mapFailure(GetPostByIdFailure.unknown);
  }

  @override
  Future<Either<DeletePostsFailure, Unit>> deletePosts({required List<Id> postIds}) => _gqlClient
      .mutate(
        document: deletePostsMutation,
        variables: {
          'ids': postIds.map((it) => it.value).toList(),
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['deletePosts'] as Map<String, dynamic>),
      )
      .mapFailure(DeletePostsFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const DeletePostsFailure.unknown());
}

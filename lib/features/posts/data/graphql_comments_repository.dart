import 'package:dartz/dartz.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/data/comments_queries.dart';
import 'package:picnic_app/features/posts/data/get_comments_query_generator.dart';
import 'package:picnic_app/features/posts/data/get_pinned_comments_query_generator.dart';
import 'package:picnic_app/features/posts/data/model/gql_comment_json.dart';
import 'package:picnic_app/features/posts/data/model/gql_pinned_comment_json.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/create_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/delete_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comment_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_preview_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_pinned_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/pin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/model/unpin_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';
import 'package:picnic_app/utils/extensions/tree_extension.dart';

class GraphQlCommentsRepository implements CommentsRepository {
  GraphQlCommentsRepository(
    this._gqlClient,
    this._getCommentsQueryGenerator,
  );

  static const permissionDenied = 'PermissionDenied';

  final GraphQLClient _gqlClient;

  final GetCommentsQueryGenerator _getCommentsQueryGenerator;

  @override
  Future<Either<LikeUnlikeCommentFailure, Unit>> likeDislikeComment({
    required Id commentId,
    required LikeDislikeReaction likeDislikeReaction,
  }) =>
      _gqlClient
          .mutate(
            document: reactToCommentMutation,
            variables: {
              'commentId': commentId.value,
              'reaction': likeDislikeReaction.value,
            },
            parseData: (_) => unit,
          )
          .mapFailure(LikeUnlikeCommentFailure.unknown)
          .mapSuccess((_) => unit);

  @override
  Future<Either<UnreactToCommentFailure, Unit>> unReactToComment({
    required Id commentId,
  }) =>
      _gqlClient
          .mutate(
            document: unToReactCommentMutation,
            variables: {
              'commentId': commentId.value,
            },
            parseData: (_) => unit,
          )
          .mapFailure(UnreactToCommentFailure.unknown)
          .mapSuccess((_) => unit);

  @override
  Future<Either<GetCommentsFailure, TreeComment>> getComments({
    required Post post,
    Cursor cursor = const Cursor.firstPage(
      pageSize: Cursor.extendedPageSize,
    ),
    Id parentCommentId = const Id.empty(),
    int depthLevel = Constants.defaultCommentsDepthLevel,
  }) async {
    return _gqlClient
        .query(
          document: _getCommentsQueryGenerator.build(
            maxDepth: depthLevel,
          ),
          variables: {
            'postId': post.id.value,
            'parentId': parentCommentId.value,
            'cursor1': cursor.toGqlCursorInput(),
          },
          parseData: (json) {
            final getCommentsData = json['getComments'] as Map<String, dynamic>;
            return GqlConnection.fromJson(getCommentsData);
          },
        )
        .mapFailure(GetCommentsFailure.unknown)
        .mapSuccess(
          (connection) => TreeComment.root(
            children: connection.toDomain(
              nodeMapper: (node) => GqlCommentJson.fromJson(node).toTreeComment(
                postAuthorId: post.author.id,
              ),
            ),
          ).normalizeConnections(),
        );
  }

  @override
  Future<Either<GetCommentsPreviewFailure, List<CommentPreview>>> getCommentsPreview({
    required Id postId,
    int count = Constants.defaultCommentsPreviewCount,
  }) async {
    return _gqlClient
        .query(
          document: _getCommentsQueryGenerator.build(
            maxDepth: 1,
            limitPerLevel: count,
            reverse: true,
          ),
          variables: {
            'postId': postId.value,
          },
          parseData: (json) {
            final getCommentsData = json['getComments'] as Map<String, dynamic>;
            return GqlConnection.fromJson(getCommentsData);
          },
        )
        .mapFailure(GetCommentsPreviewFailure.unknown)
        .mapSuccess(
          (connection) => connection
              .toDomain(nodeMapper: (node) => GqlCommentJson.fromJson(node).toCommentPreview()) //
              .items,
        );
  }

  @override
  Future<Either<CreateCommentFailure, TreeComment>> createComment({
    required Id postId,
    required String text,
    required Id postAuthorId,
    Id parentCommentId = const Id.empty(),
  }) {
    return _gqlClient
        .mutate(
          document: createCommentMutation,
          variables: {
            'postId': postId.value,
            'parentId': parentCommentId.value,
            'text': text,
          },
          parseData: (json) {
            final createCommentData = json['createComment'] as Map<String, dynamic>;
            return GqlCommentJson.fromJson(createCommentData);
          },
        )
        .mapSuccess(
          (response) => response.toTreeComment(
            postAuthorId: postAuthorId,
          ),
        )
        .mapFailure(
          (fail) => fail.errorCode == permissionDenied
              ? CreateCommentFailure.permissionDenied(fail)
              : CreateCommentFailure.unknown(fail),
        );
  }

  @override
  Future<Either<DeleteCommentFailure, Unit>> deleteComment({required Id commentId}) {
    return _gqlClient
        .mutate(
          document: deleteCommentMutation,
          variables: {
            'params': {
              'id': commentId.value,
            },
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['deleteComment'] as Map<String, dynamic>),
        )
        .mapFailure(DeleteCommentFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const DeleteCommentFailure.unknown());
  }

  @override
  Future<Either<GetPinnedCommentsFailure, List<TreeComment>>> getPinnedComments({
    required Post post,
    int depthLevel = Constants.defaultCommentsDepthLevel,
  }) {
//document: getPinnedCommentsQuery,
    return _gqlClient
        .query(
          document: const GetPinnedCommentsQueryGenerator().build(
            maxDepth: depthLevel,
          ),
          variables: {
            'postId': post.id.value,
          },
          parseData: (json) {
            final list = asList(
              json,
              'getPinnedComments',
              GqlPinnedCommentJson.fromJson,
            );
            return list
                .map(
                  (e) => e.toTreeComment(postAuthorId: post.author.id),
                )
                .map(
                  (e) => e.copyWith(isPinned: true),
                )
                .toList();
          },
        )
        .mapFailure(GetPinnedCommentsFailure.unknown);
  }

  @override
  Future<Either<PinCommentFailure, Unit>> pinComment({
    required Id commentId,
  }) {
    return _gqlClient
        .mutate(
          document: pinCommentMutation,
          variables: {
            'commentId': commentId.value,
            'order': 0,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['pinComment'] as Map<String, dynamic>),
        )
        .mapFailure(PinCommentFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const PinCommentFailure.unknown());
  }

  @override
  Future<Either<UnpinCommentFailure, Unit>> unpinComment({
    required Id commentId,
  }) {
    return _gqlClient
        .mutate(
          document: unpinCommentMutation,
          variables: {
            'commentId': commentId.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['unpinComment'] as Map<String, dynamic>),
        )
        .mapFailure(UnpinCommentFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const UnpinCommentFailure.unknown());
  }

  @override
  Future<Either<GetCommentByIdFailure, TreeComment>> getCommentById({required Id commentId}) {
    return _gqlClient
        .query(
          document: getCommentByIdQuery,
          variables: {
            'id': commentId.value,
          },
          parseData: (json) {
            final comment = json['getComment'] as Map<String, dynamic>;
            return GqlCommentJson.fromJson(comment).toTreeComment();
          },
        )
        .mapFailure(GetCommentByIdFailure.unknown);
  }
}

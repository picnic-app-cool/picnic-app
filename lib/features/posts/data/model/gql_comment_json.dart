import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comment_tag.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class GqlCommentJson {
  const GqlCommentJson({
    required this.id,
    required this.text,
    required this.authorJson,
    required this.repliesCount,
    required this.repliesConnection,
    required this.likesCount,
    required this.iReacted,
    required this.postId,
    required this.createdAt,
    this.deletedAt,
  });

  factory GqlCommentJson.fromJson(Map<String, dynamic>? json) => GqlCommentJson(
        id: asT<String>(json, 'id'),
        text: asT<String>(json, 'text'),
        authorJson: asT<Map<String, dynamic>>(json, 'author'),
        repliesCount: asT<int>(json, 'repliesCount'),
        repliesConnection: asT<Map<String, dynamic>>(json, 'repliesConnection'),
        likesCount: asT<int>(json, 'likesCount'),
        iReacted: asT<bool>(json, 'iReacted'),
        postId: asT<String>(json, 'postId'),
        createdAt: asT<String>(json, 'createdAt'),
        deletedAt: asT<String?>(json, 'deletedAt'),
      );

  final String id;
  final String text;
  final Map<String, dynamic> authorJson;
  final int repliesCount;
  final Map<String, dynamic> repliesConnection;
  final int likesCount;
  final bool iReacted;
  final String postId;
  final String createdAt;
  final String? deletedAt;

  // ignore: long-method
  TreeComment toTreeComment({Id? postAuthorId}) {
    var children = GqlConnection.fromJson(repliesConnection).toDomain(
      nodeMapper: (n) {
        var comment = GqlCommentJson.fromJson(n).toTreeComment(postAuthorId: postAuthorId);
        if (postAuthorId == comment.author.id) {
          comment = comment.copyWith(tag: CommentTag.creator);
        }
        return comment;
      },
    );

    if (children.isEmptyNoMorePage && !children.hasNextPage && repliesCount != 0) {
      children = children.copyWith(
        pageInfo: children.pageInfo.copyWith(
          hasNextPage: true,
        ),
      );
    }

    final author = GqlUser.fromJson(authorJson).toDomain();

    return TreeComment(
      id: Id(id),
      text: text,
      isLiked: iReacted,
      isDeleted: deletedAt != null,
      author: author,
      isPinned: false,
      parent: const TreeComment.empty(),
      likesCount: likesCount,
      repliesCount: repliesCount,
      children: children,
      postId: Id(postId),
      createdAtString: createdAt,
      tag: postAuthorId == author.id ? CommentTag.creator : null,
    );
  }

  CommentPreview toCommentPreview() {
    return CommentPreview(
      id: Id(id),
      text: text,
      isLiked: iReacted,
      author: GqlUser.fromJson(authorJson).toDomain(),
      likesCount: likesCount,
      repliesCount: repliesCount,
      postId: Id(postId),
      createdAtString: createdAt,
    );
  }
}

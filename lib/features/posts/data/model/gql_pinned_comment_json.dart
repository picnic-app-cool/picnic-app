import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/data/model/gql_comment_json.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class GqlPinnedCommentJson {
  const GqlPinnedCommentJson({
    required this.comment,
  });

  factory GqlPinnedCommentJson.fromJson(Map<String, dynamic> json) => GqlPinnedCommentJson(
        comment: GqlCommentJson.fromJson(json),
      );

  final GqlCommentJson comment;

  // ignore: long-method
  TreeComment toTreeComment({Id? postAuthorId}) => comment.toTreeComment(postAuthorId: postAuthorId);

  CommentPreview toCommentPreview() => comment.toCommentPreview();
}

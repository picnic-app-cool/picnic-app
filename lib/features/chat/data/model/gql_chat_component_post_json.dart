import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_post_payload.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GqlChatComponentPostJson {
  const GqlChatComponentPostJson({
    required this.postId,
    required this.post,
  });

  factory GqlChatComponentPostJson.fromJson(Map<String, dynamic>? json) {
    GqlPost? _post;
    try {
      _post = GqlPost.fromJson(json!['post'] as Map<String, dynamic>);
    } catch (e) {
      doNothing();
    }
    return GqlChatComponentPostJson(
      postId: asT<String>(json, 'postId'),
      post: _post,
    );
  }

  final String postId;
  final GqlPost? post;

  /// This is a workaround to get the userStore from the global injector.
  /// It seems impossible to pass userStore here through all other Gql classes. Too much dependencies.
  /// Need to refactor this in the future. Maybe we can move toDomain function to separate class.
  UserStore get userStore => getIt();

  ChatMessagePostPayload toDomain() => ChatMessagePostPayload(
        postId: Id(postId),
        post: post?.toDomain(userStore) ?? const Post.empty(),
      );
}

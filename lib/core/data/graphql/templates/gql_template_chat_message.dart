import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_attachment.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_member.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message_reaction.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';
import 'package:picnic_app/features/chat/data/model/templates/gql_template_embed.dart';

extension GqlTemplateChatMessage on GqlTemplate {
  String get chatMessage => '''
$_chatMessage
$_chatMessageReplyContent
''';

  String get _chatMessage => '''
id
author {
  $user
}
content
type
reactions {
  $chatMessageReaction
}
createdAt
component {
    type
    payload {
      $_payloadCircleInvite
      $_payloadGlitterBomb
      $_payloadPost
    }
}
attachmentIds
attachments {
  ${GqlTemplate().attachment}
}
embeds {
  ${GqlTemplate().embed}
}
member {
  ${GqlTemplate().chatMessageMember}
}
''';

  String get _chatMessageReplyContent => '''
replyContent {
  $_chatMessage
}
''';

  String get _payloadCircleInvite => '''
... on ChatCircleInvite {
    circleId
    circle {
      ${GqlTemplate().basicCircle}
    }
    userId
}
''';

  String get _payloadGlitterBomb => '''
... on ChatGlitterBomb {
    sender {
      id,
      username,
      }
}
''';

  String get _payloadPost => '''
... on ChatMessagePost {
    postId
    post {
      ${GqlTemplate().post}
    }
}
''';
}

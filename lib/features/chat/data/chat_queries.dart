import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_excerpt.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_member.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message_reaction.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';

String sendMessageMutation = """
mutation sendChatMessage(\$chatId: ID!, \$message: ChatMessageInput!) {
  sendChatMessage(chatId: \$chatId, message: \$message) {
      ${GqlTemplate().chatMessage}
  }
}
""";

String joinChatQuery = """
query joinChat(\$chatId: ID!) {
  joinChat(chatId: \$chatId) {
      ${GqlTemplate().successPayload}
  }
}
""";

String get leaveChatMutation => """
mutation leaveChat(\$chatId: ID!) {
  leaveChat(chatId: \$chatId) {
      ${GqlTemplate().successPayload}
  }
}
""";

String chatQuery = """
query chat(\$chatId: ID!) {
  chat(id: \$chatId) {
    ${GqlTemplate().chatWithCircle}
  }
}
""";

String get chatSettingsQuery => """
query chatSettings(\$chatId: ID!) {
  chatSettings(chatId: \$chatId) {
    ${GqlTemplate().chatSettings}
  }
}
""";

String get updateChatSettingsMutation => """
mutation updateChatSettings(\$chatId: ID!, \$settings: ChatSettingsInput!) {
  updateChatSettings(chatId: \$chatId, settings: \$settings) {
    ${GqlTemplate().successPayload}
  }
}
""";

String get getChatsQuery => '''
    query(\$searchQuery: String, \$chatTypes: [ChatType!], \$cursor: CursorInput!) {
        chatsConnection(searchQuery: \$searchQuery, chatTypes: \$chatTypes, cursor: \$cursor) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().basicChat + GqlTemplate().chatMessagesConnection + GqlTemplate().chatParticipantsConnection)}
        }
    }
''';

String get getChatsWithCircleQuery => '''
    query(\$searchQuery: String, \$chatTypes: [ChatType!], \$cursor: CursorInput!) {
        chatsConnection(searchQuery: \$searchQuery, chatTypes: \$chatTypes, cursor: \$cursor) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatWithCircle + GqlTemplate().chatMessagesConnection)}
        }
    }
''';

String get getRecommendedChatsQuery => '''
    query(\$kind: ChatRecommendationKind!, \$search: String, \$context: GetRecommendedChatsContext, \$cursor: CursorInput) {
        getRecommendedChats(input: {
          kind: \$kind,
          search: \$search,
          context: \$context,
          cursor: \$cursor
        }) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatWithCircle + GqlTemplate().chatParticipantsConnection)}
        }
    }
''';

String get getChatFeedsQuery => '''
    query(\$cursor: CursorInput) {
        chatFeedConnection(cursor: \$cursor) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatExcerpt)}
        }
    }
''';

String chatMessagesQuery = """
query chatMessages(\$chatId: ID!, \$cursor: CursorInput!) {
  chat(id: \$chatId) {
    messagesConnection(cursor: \$cursor) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatMessage)}
    }
  }
}
""";

String deleteMessageMutation = """
mutation deleteMessage(\$messageId: ID!) {
  deleteMessage(messageId: \$messageId) {
    ${GqlTemplate().successPayload}
  }
}
""";

String reactToMessageMutation = """
mutation reactToMessage(\$messageId: ID!, \$reaction: String!) {
  reactToMessage(messageId: \$messageId, reaction: \$reaction) {
      ${GqlTemplate().chatMessageReaction}
  }
}
""";

String unreactToMessageMutation = """
mutation unreactToMessage(\$messageId: ID!, \$reaction: String!) {
  unreactToMessage(messageId: \$messageId, reaction: \$reaction) {
      ${GqlTemplate().chatMessageReaction}
  }
}
""";

String get createGroupChatMutation => """
mutation createGroupChat(\$chatConfiguration: GroupChatInput!) {
  createGroupChat(chatConfiguration: \$chatConfiguration) {
    ${GqlTemplate().basicChat + GqlTemplate().chatParticipantsConnection}
  },
}
""";

const String createSingleChatMutation = """
mutation createSingleChat(\$chatConfiguration: SingleChatInput!) {
  createSingleChat(chatConfiguration: \$chatConfiguration) {
      id
      chatType
      participantsCount
  }
}
""";

String get chatParticipantsQuery => """
query chatMembers(\$chatId: ID!, \$cursor: CursorInput!) {
  chat(id: \$chatId) {
    participantsConnection(cursor: \$cursor) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().user)}
    }
  }
}
""";

String get removeUserFromChatMutation => """
mutation removeUserFromChat(\$chatId: ID!, \$userId: ID!) {
  removeUserFromChat(chatId: \$chatId, userId: \$userId) {
    ${GqlTemplate().successPayload}
  }
}
""";

String get addUserToChatMutation => """
mutation addUserToChat(\$chatId: ID!, \$userId: ID!) {
  addUserToChat(chatId: \$chatId, userId: \$userId) {
    ${GqlTemplate().successPayload}
  }
}
""";

String get chatMembersQuery => """
query chatMembers(\$chatId: ID!, \$cursor: CursorInput!) {
  chat(id: \$chatId) {
    membersConnection(cursor: \$cursor) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatMember)}
    }
  }
}
""";

String get unreadChatsQuery => """
query unreadChats { 
   unreadChats() {
     ${GqlTemplate().chatMetaData}
     }
}
""";

String get markMessageAsReadQuery => """
mutation markMessageAsRead(\$messageId: ID!) { 
   markMessageAsRead(messageId: \$messageId) {
     ${GqlTemplate().successPayload}
     }
}
""";

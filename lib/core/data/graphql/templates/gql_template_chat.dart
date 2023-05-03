import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';

extension GqlTemplateChat on GqlTemplate {
  String get basicChat => '''
id
name
chatType
chatImage
participantsCount
unreadMessagesCount
''';

  String get chatMessagesConnection => '''
messagesConnection {
    ${GqlTemplate().connection(nodeTemplate: GqlTemplate().chatMessage)}
}
''';

  String get chatParticipantsConnection => '''
participantsConnection {
    ${GqlTemplate().connection(nodeTemplate: GqlTemplate().user)}
}
''';

  String get chatSettings => '''
isMuted
''';

  String get chatWithCircle => '''
$basicChat
circle {
  ${GqlTemplate().basicCircle}
}
''';

  String get chatMetaData => '''
    chatId,
    chatType,
    lastMessageAt
''';
}

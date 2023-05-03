import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';

extension GqlTemplateChatExcerpt on GqlTemplate {
  String get chatExcerpt => '''
            id
            name
            imageUrl
            chatType
            language
            participantsCount
            circle {
              ${GqlTemplate().circleWithChat}
            }
            messages {
              ${GqlTemplate().chatMessage}
            }
''';
}

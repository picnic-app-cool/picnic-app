import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateChatMessageReaction on GqlTemplate {
  String get chatMessageReaction => '''
reaction
hasReacted
count
''';
}

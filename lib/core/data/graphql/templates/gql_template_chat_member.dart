import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';

extension GqlTemplateChatMember on GqlTemplate {
  String get chatMember => '''
userId
role
user {
  ${GqlTemplate().user}
}
''';

  String get chatMessageMember => '''
userId
role
''';
}

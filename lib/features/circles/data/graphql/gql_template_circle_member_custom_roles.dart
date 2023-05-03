import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_custom_role.dart';

extension GqlTemplateCircleMemberCustomRoles on GqlTemplate {
  String get circleMemberCustomRoles => '''
    roles {
      ${GqlTemplate().customRole}
    }
    mainRoleId
    unassigned {
      ${GqlTemplate().customRole}
    }
''';
}

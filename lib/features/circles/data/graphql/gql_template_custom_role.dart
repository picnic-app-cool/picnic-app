import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateCustomRole on GqlTemplate {
  String get customRole => '''
    circleId
    roleId
    name
    emoji
    color
    canPost
    canSendMsg
    canEmbedLinks
    canAttachFiles
    canManageUsers
    canManagePosts
    canManageRoles
    canManageCircle
    canManageMessages
    canManageReports
    canManageComments
    meta {
        configurable
        deletable
        assignable
    }
''';
}

import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateCirclePermissions on GqlTemplate {
  String get circlePermissions => '''
  canPost
	canSendMsg
	canEmbedLinks
	canAttachFiles
	canManageCircle
	canManageUsers
	canManageReports
	canManagePosts
	canManageMessages
	canManageRoles
	canManageComments
''';
}

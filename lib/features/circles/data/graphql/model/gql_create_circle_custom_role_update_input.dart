import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';

extension GqlCreateCircleCustomRoleupdateInput on CircleCustomRoleUpdateInput {
  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId.value,
      'roleId': roleId.value,
      'name': name,
      'color': color,
      'emoji': emoji,
      'canPost': canPostContent,
      'canSendMsg': canSendMessages,
      'canEmbedLinks': canEmbedLinks,
      'canAttachFiles': canAttachFiles,
      'canManageUsers': canManageUsers,
      'canManagePosts': canManagePosts,
      'canManageRoles': canManageRoles,
      'canManageCircle': canManageCircle,
      'canManageMessages': canManageMessages,
      'canManageReports': canManageReports,
      'canManageComments': canManageComments,
    };
  }
}

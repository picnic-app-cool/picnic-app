import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';

extension GqlCreateCircleCustomRoleInput on CircleCustomRoleInput {
  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId.value,
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

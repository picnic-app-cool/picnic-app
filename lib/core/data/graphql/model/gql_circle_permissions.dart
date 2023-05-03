import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/circle_permissions.dart';

class GqlCirclePermissions {
  const GqlCirclePermissions({
    required this.canPost,
    required this.canSendMsg,
    required this.canEmbedLinks,
    required this.canAttachFiles,
    required this.canManageCircle,
    required this.canManageUsers,
    required this.canManageReports,
    required this.canManagePosts,
    required this.canManageMessages,
    required this.canManageRoles,
    required this.canManageComments,
  });

  factory GqlCirclePermissions.fromJson(Map<String, dynamic>? json) {
    return GqlCirclePermissions(
      canPost: asT<bool>(json, 'canPost'),
      canSendMsg: asT<bool>(json, 'canSendMsg'),
      canEmbedLinks: asT<bool>(json, 'canEmbedLinks'),
      canAttachFiles: asT<bool>(json, 'canAttachFiles'),
      canManageCircle: asT<bool>(json, 'canManageCircle'),
      canManageUsers: asT<bool>(json, 'canManageUsers'),
      canManageReports: asT<bool>(json, 'canManageReports'),
      canManagePosts: asT<bool>(json, 'canManagePosts'),
      canManageMessages: asT<bool>(json, 'canManageMessages'),
      canManageRoles: asT<bool>(json, 'canManageRoles'),
      canManageComments: asT<bool>(json, 'canManageComments'),
    );
  }

  final bool canPost;
  final bool canSendMsg;
  final bool canEmbedLinks;
  final bool canAttachFiles;
  final bool canManageCircle;
  final bool canManageUsers;
  final bool canManageReports;
  final bool canManagePosts;
  final bool canManageMessages;
  final bool canManageRoles;
  final bool canManageComments;

  CirclePermissions toDomain() => CirclePermissions(
        canPost: canPost,
        canSendMsg: canSendMsg,
        canEmbedLinks: canEmbedLinks,
        canAttachFiles: canAttachFiles,
        canManageCircle: canManageCircle,
        canManageUsers: canManageUsers,
        canManageReports: canManageReports,
        canManagePosts: canManagePosts,
        canManageMessages: canManageMessages,
        canManageRoles: canManageRoles,
        canManageComments: canManageComments,
      );
}

import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/data/graphql/model/gql_custom_role_meta.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/custom_role_meta.dart';

class GqlCircleCustomRole {
  const GqlCircleCustomRole({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.canEmbedLinks,
    required this.canAttachFiles,
    required this.canPostContent,
    required this.canSendMessages,
    required this.canManageUsers,
    required this.canManagePosts,
    required this.canManageRoles,
    required this.canManageCircle,
    required this.canManageMessages,
    required this.canManageReports,
    required this.canManageComments,
    required this.meta,
  });

  factory GqlCircleCustomRole.fromJson(Map<String, dynamic>? json) {
    GqlCustomRoleMeta? customRoleMeta;

    if (json != null && json['meta'] != null) {
      customRoleMeta = GqlCustomRoleMeta.fromJson((json['meta'] as Map).cast());
    }

    return GqlCircleCustomRole(
      id: asT<String>(json, 'roleId'),
      name: asT<String>(json, 'name'),
      emoji: asT<String>(json, 'emoji'),
      color: asT<String>(json, 'color'),
      canPostContent: asT<bool>(json, 'canPost'),
      canSendMessages: asT<bool>(json, 'canSendMsg'),
      canEmbedLinks: asT<bool>(json, 'canEmbedLinks'),
      canAttachFiles: asT<bool>(json, 'canAttachFiles'),
      canManageCircle: asT<bool>(json, 'canManageCircle'),
      canManageComments: asT<bool>(json, 'canManageComments'),
      canManageMessages: asT<bool>(json, 'canManageMessages'),
      canManagePosts: asT<bool>(json, 'canManagePosts'),
      canManageReports: asT<bool>(json, 'canManageReports'),
      canManageRoles: asT<bool>(json, 'canManageRoles'),
      canManageUsers: asT<bool>(json, 'canManageUsers'),
      meta: customRoleMeta,
    );
  }

  final String id;
  final String name;
  final String emoji;
  final bool canPostContent;
  final bool canSendMessages;
  final bool canEmbedLinks;
  final bool canAttachFiles;

  final bool canManageUsers;
  final bool canManagePosts;
  final bool canManageRoles;
  final bool canManageCircle;
  final bool canManageMessages;
  final bool canManageReports;
  final bool canManageComments;

  final String color;
  final GqlCustomRoleMeta? meta;

  CircleCustomRole toDomain() => CircleCustomRole(
        id: Id(id),
        name: normalizeString(name),
        emoji: emoji,
        canEmbedLinks: canEmbedLinks,
        canAttachFiles: canAttachFiles,
        canPostContent: canPostContent,
        canSendMessages: canSendMessages,
        color: color,
        canManageCircle: canManageCircle,
        canManageComments: canManageComments,
        canManageMessages: canManageMessages,
        canManagePosts: canManagePosts,
        canManageReports: canManageReports,
        canManageRoles: canManageRoles,
        canManageUsers: canManageUsers,
        meta: meta?.toDomain() ?? const CustomRoleMeta.empty(),
      );
}

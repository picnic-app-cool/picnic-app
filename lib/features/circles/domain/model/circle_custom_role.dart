import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/custom_role_meta.dart';

class CircleCustomRole extends Equatable {
  const CircleCustomRole({
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

  const CircleCustomRole.empty()
      : id = const Id.empty(),
        name = '',
        emoji = '',
        color = '',
        canEmbedLinks = false,
        canAttachFiles = false,
        canPostContent = false,
        canSendMessages = false,
        canManageUsers = false,
        canManagePosts = false,
        canManageRoles = false,
        canManageCircle = false,
        canManageMessages = false,
        canManageReports = false,
        canManageComments = false,
        meta = const CustomRoleMeta.empty();

  const CircleCustomRole.defaultRole()
      : id = const Id.empty(),
        name = '',
        color = '',
        emoji = '🙋‍️️',
        canEmbedLinks = true,
        canAttachFiles = true,
        canPostContent = true,
        canSendMessages = true,
        canManageUsers = false,
        canManagePosts = false,
        canManageRoles = false,
        canManageCircle = false,
        canManageMessages = false,
        canManageReports = false,
        canManageComments = false,
        meta = const CustomRoleMeta.empty();

  final Id id;
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
  final CustomRoleMeta meta;

  final String color;

  TextColor get formattedColor => TextColor.fromString(color);

  @override
  List<Object?> get props => [
        id,
        name,
        emoji,
        color,
        canEmbedLinks,
        canAttachFiles,
        canPostContent,
        canSendMessages,
        canManageUsers,
        canManagePosts,
        canManageRoles,
        canManageCircle,
        canManageMessages,
        canManageReports,
        canManageComments,
        meta,
      ];

  CircleCustomRoleInput toCircleCustomRoleInput({required Id circleId}) {
    return const CircleCustomRoleInput.empty().copyWith(
      circleId: circleId,
      name: name,
      color: color,
      emoji: emoji,
      canAttachFiles: canAttachFiles,
      canEmbedLinks: canEmbedLinks,
      canPostContent: canPostContent,
      canSendMessages: canSendMessages,
      canManageCircle: canManageCircle,
      canManageComments: canManageComments,
      canManageMessages: canManageMessages,
      canManagePosts: canManagePosts,
      canManageReports: canManageReports,
      canManageRoles: canManageRoles,
      canManageUsers: canManageUsers,
    );
  }

  CircleCustomRoleUpdateInput toUpdateCircleCustomRoleInput({required Id circleId}) {
    return const CircleCustomRoleUpdateInput.empty().copyWith(
      circleId: circleId,
      roleId: id,
      name: name,
      emoji: emoji,
      color: color,
      canAttachFiles: canAttachFiles,
      canEmbedLinks: canEmbedLinks,
      canPostContent: canPostContent,
      canSendMessages: canSendMessages,
      canManageCircle: canManageCircle,
      canManageComments: canManageComments,
      canManageMessages: canManageMessages,
      canManagePosts: canManagePosts,
      canManageReports: canManageReports,
      canManageRoles: canManageRoles,
      canManageUsers: canManageUsers,
    );
  }

  CircleCustomRole copyWith({
    Id? id,
    String? name,
    String? emoji,
    bool? canPostContent,
    String? color,
    bool? canSendMessages,
    bool? canEmbedLinks,
    bool? canAttachFiles,
    bool? canManageUsers,
    bool? canManagePosts,
    bool? canManageRoles,
    bool? canManageCircle,
    bool? canManageMessages,
    bool? canManageReports,
    bool? canManageComments,
    CustomRoleMeta? meta,
  }) {
    return CircleCustomRole(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      canEmbedLinks: canEmbedLinks ?? this.canEmbedLinks,
      canAttachFiles: canAttachFiles ?? this.canAttachFiles,
      canPostContent: canPostContent ?? this.canPostContent,
      canSendMessages: canSendMessages ?? this.canSendMessages,
      canManageUsers: canManageUsers ?? this.canManageUsers,
      canManagePosts: canManagePosts ?? this.canManagePosts,
      canManageRoles: canManageRoles ?? this.canManageRoles,
      canManageCircle: canManageCircle ?? this.canManageCircle,
      canManageMessages: canManageMessages ?? this.canManageMessages,
      canManageReports: canManageReports ?? this.canManageReports,
      canManageComments: canManageComments ?? this.canManageComments,
      meta: meta ?? this.meta,
    );
  }
}

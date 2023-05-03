import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CircleCustomRoleInput extends Equatable {
  const CircleCustomRoleInput({
    required this.circleId,
    required this.name,
    required this.emoji,
    required this.color,
    required this.canPostContent,
    required this.canSendMessages,
    required this.canEmbedLinks,
    required this.canAttachFiles,
    required this.isJoined,
    required this.canManageUsers,
    required this.canManagePosts,
    required this.canManageRoles,
    required this.canManageCircle,
    required this.canManageMessages,
    required this.canManageReports,
    required this.canManageComments,
  });

  const CircleCustomRoleInput.empty()
      : circleId = const Id.empty(),
        name = '',
        color = '',
        emoji = '',
        canEmbedLinks = false,
        canAttachFiles = false,
        canPostContent = false,
        canSendMessages = false,
        isJoined = false,
        canManageUsers = false,
        canManagePosts = false,
        canManageRoles = false,
        canManageCircle = false,
        canManageMessages = false,
        canManageReports = false,
        canManageComments = false;

  final Id circleId;
  final String name;
  final String color;
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
  final bool isJoined;

  @override
  List<Object> get props {
    return [
      circleId,
      name,
      color,
      emoji,
      canPostContent,
      canSendMessages,
      canEmbedLinks,
      canAttachFiles,
      canManageUsers,
      canManagePosts,
      canManageRoles,
      canManageCircle,
      canManageMessages,
      canManageReports,
      canManageComments,
      isJoined,
    ];
  }

  CircleCustomRoleInput copyWith({
    Id? circleId,
    String? name,
    String? color,
    String? emoji,
    bool? canPostContent,
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
    bool? isJoined,
  }) {
    return CircleCustomRoleInput(
      circleId: circleId ?? this.circleId,
      name: name ?? this.name,
      color: color ?? this.color,
      emoji: emoji ?? this.emoji,
      canPostContent: canPostContent ?? this.canPostContent,
      canSendMessages: canSendMessages ?? this.canSendMessages,
      canEmbedLinks: canEmbedLinks ?? this.canEmbedLinks,
      canAttachFiles: canAttachFiles ?? this.canAttachFiles,
      canManageUsers: canManageUsers ?? this.canManageUsers,
      canManagePosts: canManagePosts ?? this.canManagePosts,
      canManageRoles: canManageRoles ?? this.canManageRoles,
      canManageCircle: canManageCircle ?? this.canManageCircle,
      canManageMessages: canManageMessages ?? this.canManageMessages,
      canManageReports: canManageReports ?? this.canManageReports,
      canManageComments: canManageComments ?? this.canManageComments,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}

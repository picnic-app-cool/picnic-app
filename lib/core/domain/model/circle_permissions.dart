import 'package:equatable/equatable.dart';

class CirclePermissions extends Equatable {
  const CirclePermissions({
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

  const CirclePermissions.empty()
      : canPost = false,
        canSendMsg = false,
        canEmbedLinks = false,
        canAttachFiles = false,
        canManageCircle = false,
        canManageUsers = false,
        canManageReports = false,
        canManagePosts = false,
        canManageMessages = false,
        canManageRoles = false,
        canManageComments = false;

  const CirclePermissions.defaultPermissions()
      : canPost = true,
        canSendMsg = true,
        canEmbedLinks = true,
        canAttachFiles = true,
        canManageCircle = true,
        canManageUsers = true,
        canManageReports = true,
        canManagePosts = true,
        canManageMessages = true,
        canManageRoles = true,
        canManageComments = true;

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

  @override
  List<Object?> get props => [
        canPost,
        canSendMsg,
        canEmbedLinks,
        canAttachFiles,
        canManageCircle,
        canManageUsers,
        canManageReports,
        canManagePosts,
        canManageMessages,
        canManageRoles,
        canManageComments,
      ];

  CirclePermissions copyWith({
    bool? canPost,
    bool? canSendMsg,
    bool? canEmbedLinks,
    bool? canAttachFiles,
    bool? canManageCircle,
    bool? canManageUsers,
    bool? canManageReports,
    bool? canManagePosts,
    bool? canManageMessages,
    bool? canManageRoles,
    bool? canManageComments,
  }) =>
      CirclePermissions(
        canPost: canPost ?? this.canPost,
        canSendMsg: canSendMsg ?? this.canSendMsg,
        canEmbedLinks: canEmbedLinks ?? this.canEmbedLinks,
        canAttachFiles: canAttachFiles ?? this.canAttachFiles,
        canManageCircle: canManageCircle ?? this.canManageCircle,
        canManageUsers: canManageUsers ?? this.canManageUsers,
        canManageReports: canManageReports ?? this.canManageReports,
        canManagePosts: canManagePosts ?? this.canManagePosts,
        canManageMessages: canManageMessages ?? this.canManageMessages,
        canManageRoles: canManageRoles ?? this.canManageRoles,
        canManageComments: canManageComments ?? this.canManageComments,
      );
}

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/circle_permissions.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class Circle extends Equatable {
  const Circle({
    required this.id,
    required this.name,
    required this.moderationType,
    required this.description,
    required this.emoji,
    required this.imageFile,
    required this.languageCode,
    required this.membersCount,
    required this.shareLink,
    required this.rulesText,
    required this.circleRole,
    required this.isBanned,
    required this.isVerified,
    required this.iJoined,
    required this.groupId,
    required this.visibility,
    required this.reportsCount,
    required this.configs,
    required this.chat,
    required this.coverImage,
    required this.permissions,
    required this.roles,
  });

  const Circle.empty()
      : id = const Id.empty(),
        name = '',
        membersCount = 0,
        shareLink = '',
        rulesText = '',
        description = '',
        emoji = '',
        imageFile = '',
        moderationType = CircleModerationType.director,
        languageCode = '',
        circleRole = CircleRole.member,
        chat = const BasicChat.empty(),
        isBanned = false,
        isVerified = false,
        iJoined = false,
        groupId = const Id.empty(),
        visibility = CircleVisibility.opened,
        reportsCount = 0,
        configs = const [],
        coverImage = '',
        permissions = const CirclePermissions.defaultPermissions(),
        roles = const CircleMemberCustomRoles.empty();

  Circle.defaultCircle()
      : id = const Id.empty(),
        name = appLocalizations.defaultCircleName,
        membersCount = 0,
        shareLink = '',
        rulesText = '',
        description = '',
        emoji = '',
        imageFile = '',
        moderationType = CircleModerationType.director,
        languageCode = '',
        circleRole = CircleRole.member,
        chat = const BasicChat.empty(),
        isBanned = false,
        isVerified = false,
        iJoined = false,
        groupId = const Id.empty(),
        visibility = CircleVisibility.opened,
        reportsCount = 0,
        configs = [],
        coverImage = '',
        permissions = const CirclePermissions.defaultPermissions(),
        roles = const CircleMemberCustomRoles.empty();

  /// states the number of circles that are required to be selected in onboarding
  static const requiredNumberOfCirclesInOnBoarding = 1;

  final Id id;
  final String name;
  final int membersCount;
  final String shareLink;
  final String rulesText;
  final CircleModerationType moderationType;
  final String description;
  final String emoji;
  final String imageFile;
  final String languageCode;
  final CircleRole circleRole;
  final bool isBanned;
  final bool iJoined;
  final bool isVerified;
  final CircleVisibility visibility;
  final int reportsCount;
  final List<CircleConfig> configs;
  final String coverImage;
  final CirclePermissions permissions;
  final CircleMemberCustomRoles roles;

  final Id groupId;

  final BasicChat chat;

  bool get isDirector => circleRole == CircleRole.director;

  // TODO - Circles should carry info about royalty status https://picnic-app.atlassian.net/browse/GS-2944
  bool get isRoyalty => false;

  String get roleDisplayText => circleRole.value.toLowerCase();

  String get inviteCircleLink => shareLink;

  bool get commentsEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.comments);
    return config?.enabled ?? true;
  }

  bool get chatEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.chatting);
    return config?.enabled ?? true;
  }

  bool get textPostingEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.text);
    return config?.enabled ?? true;
  }

  bool get imagePostingEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.photo);
    return config?.enabled ?? true;
  }

  bool get videoPostingEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.video);
    return config?.enabled ?? true;
  }

  bool get pollPostingEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.poll);
    return config?.enabled ?? true;
  }

  bool get linkPostingEnabled {
    if (isDirector) {
      return true;
    }
    final config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.link);
    return config?.enabled ?? true;
  }

  bool get postingEnabled {
    if (isDirector) {
      return true;
    }
    return configs.any(
      (config) =>
          (config.type == CircleConfigType.photo ||
              config.type == CircleConfigType.video ||
              config.type == CircleConfigType.poll ||
              config.type == CircleConfigType.text ||
              config.type == CircleConfigType.link) &&
          config.enabled,
    );
  }

  bool get hasPermissionToChat => permissions.canSendMsg;

  bool get hasPermissionToPost => permissions.canPost;

  bool get hasPermissionToManageCircle => permissions.canManageCircle;

  bool get hasPermissionToAttachFiles => permissions.canAttachFiles;

  bool get hasPermissionToManageUsers => permissions.canManageUsers;

  bool get hasPermissionToManageReports => permissions.canManageReports;

  bool get hasPermissionToManagePosts => permissions.canManagePosts;

  bool get hasPermissionToManageMessages => permissions.canManageMessages;

  bool get hasPermissionToManageRoles => permissions.canManageRoles;

  bool get hasPermissionToManageComments => permissions.canManageComments;

  CircleCustomRole? get mainRole => roles.roles
      .whereNot((element) => element.name == 'default')
      .firstWhereOrNull((role) => role.id.value == roles.mainRoleId);

  TextColor get formattedMainRoleColor => mainRole != null ? TextColor.fromString(mainRole!.color) : TextColor.black;

  //if true, circle config option should be visible for a user
  bool get hasPermissionForCircleConfig =>
      permissions.canManagePosts || permissions.canManageMessages || permissions.canManageComments;

  //use this to return the configs that someone is able to configure based on their role
  List<CircleConfig> get configsAvailableBasedOnRole {
    final configsAvailableBasedOnRole = <CircleConfig>[];
    if (hasPermissionToManagePosts) {
      configsAvailableBasedOnRole.addAll(_postingRelatedCircleConfigs);
    }
    if (hasPermissionToManageComments) {
      configsAvailableBasedOnRole.addAll(_commentingRelatedCircleConfigs);
    }
    if (hasPermissionToManageMessages) {
      configsAvailableBasedOnRole.addAll(_chattingRelatedCircleConfigs);
    }
    return configsAvailableBasedOnRole;
  }

  //if true, circle settings option should be visible for a user
  bool get hasAnyModerationPermission =>
      hasPermissionToManageCircle ||
      hasPermissionForCircleConfig ||
      hasPermissionToManageUsers ||
      hasPermissionToManageReports ||
      hasPermissionToManagePosts ||
      hasPermissionToManageMessages ||
      hasPermissionToManageRoles ||
      hasPermissionToManageComments;

  @override
  List<Object> get props => [
        id,
        name,
        membersCount,
        shareLink,
        moderationType,
        description,
        emoji,
        imageFile,
        languageCode,
        languageCode,
        rulesText,
        isBanned,
        isVerified,
        iJoined,
        groupId,
        chat,
        visibility,
        reportsCount,
        configs,
        coverImage,
        permissions,
        circleRole,
        roles,
      ];

  List<CircleConfig> get _postingRelatedCircleConfigs => configs
      .where(
        (config) =>
            config.type == CircleConfigType.photo ||
            config.type == CircleConfigType.video ||
            config.type == CircleConfigType.poll ||
            config.type == CircleConfigType.text ||
            config.type == CircleConfigType.link,
      )
      .toList();

  List<CircleConfig> get _chattingRelatedCircleConfigs =>
      configs.where((config) => config.type == CircleConfigType.chatting).toList();

  List<CircleConfig> get _commentingRelatedCircleConfigs => configs
      .where(
        (config) => config.type == CircleConfigType.comments,
      )
      .toList();

  Circle copyWith({
    Id? id,
    String? name,
    int? membersCount,
    String? shareLink,
    String? rulesText,
    CircleModerationType? moderationType,
    String? description,
    String? emoji,
    String? imageFile,
    String? languageCode,
    CircleRole? circleRole,
    bool? isBanned,
    bool? isVerified,
    bool? iJoined,
    Id? groupId,
    BasicChat? chat,
    CircleVisibility? visibility,
    int? reportsCount,
    List<CircleConfig>? configs,
    String? coverImage,
    CirclePermissions? permissions,
    CircleMemberCustomRoles? roles,
  }) {
    return Circle(
      id: id ?? this.id,
      name: name ?? this.name,
      membersCount: membersCount ?? this.membersCount,
      shareLink: shareLink ?? this.shareLink,
      rulesText: rulesText ?? this.rulesText,
      moderationType: moderationType ?? this.moderationType,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      imageFile: imageFile ?? this.imageFile,
      languageCode: languageCode ?? this.languageCode,
      circleRole: circleRole ?? this.circleRole,
      isVerified: isVerified ?? this.isVerified,
      isBanned: isBanned ?? this.isBanned,
      iJoined: iJoined ?? this.iJoined,
      groupId: groupId ?? this.groupId,
      chat: chat ?? this.chat,
      visibility: visibility ?? this.visibility,
      reportsCount: reportsCount ?? this.reportsCount,
      configs: configs ?? this.configs,
      coverImage: coverImage ?? this.coverImage,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
    );
  }

  BasicCircle toBasicCircle() {
    return BasicCircle(
      id: id,
      name: name,
      membersCount: membersCount,
      shareLink: shareLink,
      rulesText: rulesText,
      moderationType: moderationType,
      description: description,
      emoji: emoji,
      languageCode: languageCode,
      circleRole: circleRole,
      isVerified: isVerified,
      isBanned: isBanned,
      iJoined: iJoined,
      groupId: groupId,
      visibility: visibility,
      reportsCount: reportsCount,
      imageFile: imageFile,
      configs: configs,
      coverImage: coverImage,
      permissions: permissions,
      roles: roles,
    );
  }
}

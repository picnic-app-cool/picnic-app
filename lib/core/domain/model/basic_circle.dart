import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/circle_permissions.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class BasicCircle extends Equatable {
  const BasicCircle({
    required this.id,
    required this.name,
    required this.moderationType,
    required this.description,
    required this.emoji,
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
    required this.imageFile,
    required this.coverImage,
    required this.configs,
    required this.permissions,
    required this.roles,
  });

  const BasicCircle.empty()
      : id = const Id.empty(),
        name = '',
        membersCount = 0,
        shareLink = '',
        rulesText = '',
        description = '',
        emoji = '',
        moderationType = CircleModerationType.director,
        languageCode = '',
        circleRole = CircleRole.member,
        isBanned = false,
        isVerified = false,
        iJoined = false,
        groupId = const Id.empty(),
        visibility = CircleVisibility.opened,
        reportsCount = 0,
        coverImage = '',
        imageFile = '',
        configs = const [],
        permissions = const CirclePermissions.defaultPermissions(),
        roles = const CircleMemberCustomRoles.empty();

  BasicCircle.defaultCircle()
      : id = const Id.empty(),
        name = appLocalizations.defaultCircleName,
        membersCount = 0,
        shareLink = '',
        rulesText = '',
        description = '',
        emoji = '',
        moderationType = CircleModerationType.director,
        languageCode = '',
        circleRole = CircleRole.member,
        isBanned = false,
        isVerified = false,
        iJoined = false,
        groupId = const Id.empty(),
        visibility = CircleVisibility.opened,
        reportsCount = 0,
        imageFile = '',
        configs = [],
        coverImage = '',
        permissions = const CirclePermissions.defaultPermissions(),
        roles = const CircleMemberCustomRoles.empty();

  final Id id;
  final String name;
  final int membersCount;
  final String shareLink;
  final String rulesText;
  final CircleModerationType moderationType;
  final String description;
  final String emoji;
  final String languageCode;
  final CircleRole circleRole;
  final bool isBanned;
  final bool iJoined;
  final bool isVerified;
  final CircleVisibility visibility;
  final int reportsCount;
  final String imageFile;
  final List<CircleConfig> configs;
  final String coverImage;
  final CirclePermissions permissions;
  final CircleMemberCustomRoles roles;

  final Id groupId;

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

  @override
  List<Object> get props => [
        id,
        name,
        membersCount,
        shareLink,
        moderationType,
        description,
        emoji,
        languageCode,
        languageCode,
        circleRole,
        reportsCount,
        rulesText,
        isBanned,
        isVerified,
        iJoined,
        groupId,
        visibility,
        imageFile,
        coverImage,
        configs,
        roles,
      ];

  BasicCircle copyWith({
    Id? id,
    String? name,
    int? membersCount,
    String? shareLink,
    String? rulesText,
    CircleModerationType? moderationType,
    String? description,
    String? emoji,
    String? languageCode,
    CircleRole? circleRole,
    bool? isBanned,
    bool? isVerified,
    bool? iJoined,
    Id? groupId,
    CircleVisibility? visibility,
    int? reportsCount,
    String? imageFile,
    List<CircleConfig>? configs,
    String? coverImage,
    CirclePermissions? permissions,
    CircleMemberCustomRoles? roles,
  }) {
    return BasicCircle(
      id: id ?? this.id,
      name: name ?? this.name,
      membersCount: membersCount ?? this.membersCount,
      shareLink: shareLink ?? this.shareLink,
      rulesText: rulesText ?? this.rulesText,
      moderationType: moderationType ?? this.moderationType,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      languageCode: languageCode ?? this.languageCode,
      circleRole: circleRole ?? this.circleRole,
      isVerified: isVerified ?? this.isVerified,
      isBanned: isBanned ?? this.isBanned,
      iJoined: iJoined ?? this.iJoined,
      groupId: groupId ?? this.groupId,
      visibility: visibility ?? this.visibility,
      reportsCount: reportsCount ?? this.reportsCount,
      imageFile: imageFile ?? this.imageFile,
      configs: configs ?? this.configs,
      coverImage: coverImage ?? this.coverImage,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
    );
  }

  Circle toCircle({required BasicChat chat}) {
    return Circle(
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
      chat: chat,
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

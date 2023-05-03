import 'package:picnic_app/core/data/graphql/model/gql_circle_permissions.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/circle_permissions.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/data/model/gql_basic_chat_json.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/data/models/gql_circle_config_json.dart';
import 'package:picnic_app/features/circles/data/models/gql_circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';

class GqlCircle {
  const GqlCircle({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.imageFile,
    required this.membersCount,
    required this.languageCode,
    required this.rulesText,
    required this.isBanned,
    required this.isVerified,
    required this.iJoined,
    required this.circleRole,
    required this.chat,
    required this.kind,
    required this.groupId,
    required this.shareLink,
    required this.visibility,
    required this.reportsCount,
    required this.configs,
    required this.coverImage,
    required this.permissions,
    required this.roles,
  });

  //ignore: long-method
  factory GqlCircle.fromJson(Map<String, dynamic>? json) {
    GqlBasicChatJson? chat;
    List<GqlCircleConfigJson>? configs;
    GqlCirclePermissions? gqlCirclePermissions;
    GqlCircleMemberCustomRoles? circleMemberCustomRoles;

    if (json != null && json['chat'] != null) {
      chat = GqlBasicChatJson.fromJson((json['chat'] as Map).cast());
    }
    if (json != null && json['options'] != null) {
      configs = (json['options'] as List).map((e) => GqlCircleConfigJson.fromJson(e as Map<String, dynamic>)).toList();
    }

    if (json != null && json['permissions'] != null) {
      gqlCirclePermissions = GqlCirclePermissions.fromJson((json['permissions'] as Map).cast());
    }

    if (json != null && json['roles'] != null) {
      circleMemberCustomRoles = GqlCircleMemberCustomRoles.fromJson((json['roles'] as Map).cast());
    }

    return GqlCircle(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
      description: asT<String>(json, 'description'),
      image: asT<String>(json, 'image'),
      imageFile: asT<String>(json, 'imageFile'),
      rulesText: asT<String>(json, 'rulesText'),
      membersCount: asT<int>(json, 'membersCount'),
      languageCode: asT<String>(json, 'languageCode'),
      circleRole: asT<String>(json, 'role'),
      kind: asT<String>(json, 'kind'),
      chat: chat,
      isBanned: asT<bool>(json, 'isBanned'),
      isVerified: asT<bool>(json, 'isVerified'),
      iJoined: asT<bool>(json, 'iJoined'),
      groupId: asT<String>(json, 'group'),
      shareLink: asT<String>(json, 'shareLink'),
      visibility: asT<String>(json, 'visibility'),
      reportsCount: asT<int>(json, 'reportsCount'),
      configs: configs,
      coverImage: asT<String>(json, 'coverImageFile'),
      permissions: gqlCirclePermissions,
      roles: circleMemberCustomRoles,
    );
  }

  final String id;
  final String name;
  final String description;
  final String image;
  final String imageFile;
  final String rulesText;
  final int membersCount;
  final String languageCode;
  final String circleRole;
  final String kind;
  final GqlBasicChatJson? chat;
  final bool isBanned;
  final bool isVerified;
  final bool iJoined;
  final String groupId;
  final String shareLink;
  final String visibility;
  final int reportsCount;
  final List<GqlCircleConfigJson>? configs;
  final String coverImage;
  final GqlCirclePermissions? permissions;
  final GqlCircleMemberCustomRoles? roles;

  Circle toDomain() => Circle(
        id: Id(id),
        name: normalizeString(name),
        description: description,
        emoji: image,
        imageFile: imageFile,
        languageCode: languageCode,
        membersCount: membersCount,
        rulesText: rulesText,
        shareLink: shareLink,
        chat: chat?.toDomain() ?? const BasicChat.empty(),
        circleRole: CircleRole.fromString(circleRole),
        moderationType: CircleModerationType.fromString(kind),
        isBanned: isBanned,
        iJoined: iJoined,
        groupId: Id(groupId),
        isVerified: isVerified,
        visibility: CircleVisibility.fromString(visibility),
        reportsCount: reportsCount,
        configs: configs?.map((e) => e.toDomain()).toList() ?? [],
        coverImage: coverImage,
        permissions: permissions?.toDomain() ?? const CirclePermissions.defaultPermissions(),
        roles: roles?.toDomain() ?? const CircleMemberCustomRoles.empty(),
      );
}

import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlSlice {
  const GqlSlice({
    required this.id,
    required this.circleId,
    required this.name,
    required this.ownerId,
    required this.description,
    required this.image,
    required this.membersCount,
    required this.roomsCount,
    required this.iJoined,
    required this.iRequestedToJoin,
    required this.rules,
    required this.private,
    required this.discoverable,
    required this.chat,
    required this.shareLink,
    required this.pendingJoinRequestsCount,
    required this.sliceRole,
  });

  factory GqlSlice.fromJson(Map<String, dynamic>? json) {
    GqlChatJson? chat;

    if (json != null && json['chat'] != null) {
      chat = GqlChatJson.fromJson((json['chat'] as Map).cast());
    }

    return GqlSlice(
      id: asT<String>(json, 'id'),
      circleId: asT<String>(json, 'circleId'),
      name: asT<String>(json, 'name'),
      ownerId: asT<String>(json, 'ownerId'),
      description: asT<String>(json, 'description'),
      image: asT<String>(json, 'image'),
      membersCount: asT<int>(json, 'membersCount'),
      roomsCount: asT<int>(json, 'roomsCount'),
      iJoined: asT<bool>(json, 'iJoined'),
      iRequestedToJoin: asT<bool>(json, 'iRequestedToJoin'),
      rules: asT<String>(json, 'rules'),
      private: asT<bool>(json, 'private'),
      discoverable: asT<bool>(json, 'discoverable'),
      chat: chat,
      shareLink: asT<String>(json, 'shareLink'),
      pendingJoinRequestsCount: asT<int>(json, 'pendingJoinRequestsCount'),
      sliceRole: asT<String>(json, 'role'),
    );
  }

  final String id;
  final String circleId;
  final String name;
  final String ownerId;
  final String description;
  final String image;
  final int membersCount;
  final int roomsCount;
  final bool iJoined;
  final bool iRequestedToJoin;
  final String rules;
  final bool private;
  final bool discoverable;
  final GqlChatJson? chat;
  final String shareLink;
  final int pendingJoinRequestsCount;
  final String sliceRole;

  Slice toDomain() => Slice(
        id: Id(id),
        circleId: Id(circleId),
        name: name,
        ownerId: Id(ownerId),
        description: description,
        image: ImageUrl(image),
        membersCount: membersCount,
        roomsCount: roomsCount,
        iJoined: iJoined,
        iRequestedToJoin: iRequestedToJoin,
        rules: rules,
        private: private,
        discoverable: discoverable,
        chat: chat?.toDomain() ?? const Chat.empty(),
        shareLink: shareLink,
        pendingJoinRequestsCount: pendingJoinRequestsCount,
        sliceRole: SliceRole.fromString(sliceRole),
      );
}

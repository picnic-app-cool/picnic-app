import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

//ignore_for_file:nullable_field_in_domain_entity
class Slice extends Equatable {
  const Slice({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.description,
    required this.image,
    required this.circleId,
    required this.ownerId,
    required this.roomsCount,
    required this.iJoined,
    required this.iRequestedToJoin,
    required this.rules,
    required this.discoverable,
    required this.private,
    required this.shareLink,
    required this.pendingJoinRequestsCount,
    required this.sliceRole,
    Chat? chat,
  }) : _chat = chat;

  const Slice.empty()
      : id = const Id.empty(),
        name = '',
        membersCount = 0,
        description = '',
        image = const ImageUrl.empty(),
        circleId = const Id.empty(),
        ownerId = const Id.empty(),
        roomsCount = 0,
        iJoined = false,
        iRequestedToJoin = false,
        rules = '',
        discoverable = true,
        private = false,
        shareLink = '',
        pendingJoinRequestsCount = 0,
        sliceRole = SliceRole.pending,
        _chat = null;

  final Id id;
  final String name;
  final int membersCount;
  final String description;
  final ImageUrl image;
  final Id circleId;
  final Id ownerId;
  final int roomsCount;
  final bool iJoined;
  final bool iRequestedToJoin;
  final String rules;
  final bool discoverable;
  final bool private;
  final String shareLink;
  final int pendingJoinRequestsCount;
  final SliceRole sliceRole;
  final Chat? _chat;

  Chat get chat => _chat ?? const Chat.empty();

  String get inviteSliceLink => shareLink;

  @override
  List<Object> get props => [
        id,
        name,
        membersCount,
        description,
        image,
        circleId,
        ownerId,
        roomsCount,
        iJoined,
        iRequestedToJoin,
        rules,
        discoverable,
        private,
        shareLink,
        pendingJoinRequestsCount,
        sliceRole,
        if (chat != const Chat.empty()) chat,
      ];

  Slice copyWith({
    Id? id,
    String? name,
    int? membersCount,
    String? description,
    ImageUrl? image,
    Id? circleId,
    Id? ownerId,
    int? roomsCount,
    bool? iJoined,
    bool? iRequestedToJoin,
    String? rules,
    bool? discoverable,
    bool? private,
    String? shareLink,
    int? pendingJoinRequestsCount,
    Chat? chat,
    SliceRole? role,
  }) {
    return Slice(
      id: id ?? this.id,
      name: name ?? this.name,
      membersCount: membersCount ?? this.membersCount,
      description: description ?? this.description,
      image: image ?? this.image,
      circleId: circleId ?? this.circleId,
      ownerId: ownerId ?? this.ownerId,
      roomsCount: roomsCount ?? this.roomsCount,
      iJoined: iJoined ?? this.iJoined,
      iRequestedToJoin: iRequestedToJoin ?? this.iRequestedToJoin,
      rules: rules ?? this.rules,
      discoverable: discoverable ?? this.discoverable,
      private: private ?? this.private,
      shareLink: shareLink ?? this.shareLink,
      pendingJoinRequestsCount: pendingJoinRequestsCount ?? this.pendingJoinRequestsCount,
      chat: chat ?? _chat,
      sliceRole: role ?? sliceRole,
    );
  }

  SliceUpdateInput toSliceUpdateInput() => SliceUpdateInput(
        name: name,
        description: description,
        private: private,
        discoverable: discoverable,
        image: image.url,
        rules: rules,
      );
}

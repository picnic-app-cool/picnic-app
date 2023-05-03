import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class InviteUsersToCircleInput extends Equatable {
  const InviteUsersToCircleInput({
    required this.circleId,
    required this.userIds,
  });

  InviteUsersToCircleInput.empty()
      : circleId = const Id.empty(),
        userIds = List.empty();

  final Id circleId;
  final List<Id> userIds;

  @override
  List<Object> get props => [
        circleId,
        userIds,
      ];

  InviteUsersToCircleInput copyWith({
    Id? circleId,
    List<Id>? userIds,
  }) {
    return InviteUsersToCircleInput(
      circleId: circleId ?? this.circleId,
      userIds: userIds ?? this.userIds,
    );
  }
}

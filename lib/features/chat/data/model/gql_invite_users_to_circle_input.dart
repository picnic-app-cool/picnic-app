import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';

class GqlInviteUsersToCircleInput {
  const GqlInviteUsersToCircleInput({
    required this.circleId,
    required this.userIds,
  });

  factory GqlInviteUsersToCircleInput.fromDomain(InviteUsersToCircleInput input) {
    return GqlInviteUsersToCircleInput(
      circleId: input.circleId.value,
      userIds: input.userIds.map((id) => id.value).toList(),
    );
  }

  final String circleId;
  final List<String> userIds;

  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId,
      'userIDs': userIds,
    };
  }
}

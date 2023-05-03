import 'package:picnic_app/core/data/graphql/model/gql_basic_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlChatCircleInviteJson {
  const GqlChatCircleInviteJson({
    required this.circleId,
    required this.circle,
    required this.userId,
  });

  factory GqlChatCircleInviteJson.fromJson(Map<String, dynamic>? json) => GqlChatCircleInviteJson(
        circleId: asT<String>(json, 'circleId'),
        circle: asT<Map<String, dynamic>>(json, 'circle'),
        userId: asT<String>(json, 'userId'),
      );

  final String circleId;
  final Map<String, dynamic> circle;
  final String userId;

  ChatCircleInvite toDomain() => ChatCircleInvite(
        circleId: Id(circleId),
        circle: GqlBasicCircle.fromJson(circle).toDomain(),
        userId: Id(userId),
      );
}

import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlChatMemberJson {
  const GqlChatMemberJson({
    required this.userId,
    required this.role,
    this.user,
  });

  factory GqlChatMemberJson.fromJson(Map<String, dynamic>? json) => GqlChatMemberJson(
        userId: asT<String>(json, 'userId'),
        role: asT<String>(json, 'role'),
        user: asT<Map<String, dynamic>>(json, 'user'),
      );

  final String userId;
  final String role;
  final Map<String, dynamic>? user;

  ChatMember toDomain() => ChatMember(
        userId: Id(userId),
        role: ChatRole.fromString(role),
        user: user == null ? const User.empty() : GqlUser.fromJson(user!).toDomain(),
      );
}

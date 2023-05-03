import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UserRolesInitialParams {
  const UserRolesInitialParams({
    required this.user,
    required this.circleId,
  });

  final PublicProfile user;
  final Id circleId;
}

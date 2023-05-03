import 'package:picnic_app/features/chat/domain/model/id.dart';

class RolesListInitialParams {
  const RolesListInitialParams({
    required this.circleId,
    this.hasPermissionToManageRoles = true,
  });

  final Id circleId;
  final bool hasPermissionToManageRoles;
}

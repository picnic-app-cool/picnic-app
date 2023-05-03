import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';

class CircleRoleInitialParams {
  const CircleRoleInitialParams({
    required this.circleId,
    required this.formType,
    this.circleCustomRole = const CircleCustomRole.defaultRole(),
    this.onEditLoadRoles,
  });

  final Id circleId;
  final CircleRoleFormType formType;
  final CircleCustomRole circleCustomRole;
  final VoidCallback? onEditLoadRoles;
}

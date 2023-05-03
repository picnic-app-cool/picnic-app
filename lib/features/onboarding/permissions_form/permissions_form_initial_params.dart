import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';

class PermissionsFormInitialParams {
  const PermissionsFormInitialParams({
    required this.onContinue,
  });

  final void Function(RuntimePermissionStatus) onContinue;
}

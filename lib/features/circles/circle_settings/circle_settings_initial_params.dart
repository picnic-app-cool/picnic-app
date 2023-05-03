import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/utils/utils.dart';

class CircleSettingsInitialParams {
  const CircleSettingsInitialParams({
    required this.circleRole,
    required this.circle,
    this.onCirclePostDeleted,
    this.onCircleUpdated,
  });

  final CircleRole circleRole;
  final VoidCallback? onCircleUpdated;

  final Circle circle;

  final VoidCallback? onCirclePostDeleted;
}

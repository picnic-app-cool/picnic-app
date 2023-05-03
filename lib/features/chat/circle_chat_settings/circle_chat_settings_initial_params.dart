import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';

class CircleChatSettingsInitialParams {
  const CircleChatSettingsInitialParams({
    required this.circle,
    this.onCircleChanged,
  });

  final Circle circle;
  final ValueChanged<Circle>? onCircleChanged;
}

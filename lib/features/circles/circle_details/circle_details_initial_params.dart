import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CircleDetailsInitialParams {
  const CircleDetailsInitialParams({
    required this.circleId,
    this.onCircleMembershipChange,
    this.onCircleViewed,
  });

  final Id circleId;

  final VoidCallback? onCircleMembershipChange;
  final VoidCallback? onCircleViewed;
}

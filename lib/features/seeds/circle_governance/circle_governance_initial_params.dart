import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CircleGovernanceInitialParams {
  CircleGovernanceInitialParams({required this.circle}) : circleId = circle.id;

  CircleGovernanceInitialParams.byId({required this.circleId}) : circle = const Circle.empty();

  final Circle circle;
  final Id circleId;
}

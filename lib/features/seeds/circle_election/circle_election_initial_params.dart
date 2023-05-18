import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CircleElectionInitialParams {
  CircleElectionInitialParams({required this.circle, required this.circleId});

  final Circle circle;

  final Id circleId;
}

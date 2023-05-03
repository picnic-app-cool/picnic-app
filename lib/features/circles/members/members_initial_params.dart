import 'package:picnic_app/core/domain/model/circle.dart';

class MembersInitialParams {
  const MembersInitialParams({
    this.circle = const Circle.empty(),
  });

  final Circle circle;
}

import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';

class CircleGroup extends Equatable {
  const CircleGroup(this.name, this.topCircles);

  const CircleGroup.empty()
      : name = "",
        topCircles = const <Circle>[];

  final String name;
  final List<Circle> topCircles;

  @override
  List<Object?> get props => [
        name,
        topCircles,
      ];

  CircleGroup copyWith({
    String? name,
    List<Circle>? topCircles,
  }) {
    return CircleGroup(
      name ?? this.name,
      topCircles ?? this.topCircles,
    );
  }
}

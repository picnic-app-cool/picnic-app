import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GroupWithCircles extends Equatable {
  const GroupWithCircles({
    required this.name,
    required this.id,
    required this.circles,
  });

  const GroupWithCircles.empty()
      : name = '',
        id = const Id.empty(),
        circles = const [];

  /// number of circles to automatically select when grouping is selected;
  static const preselectCirclesCount = 5;

  final Id id;
  final String name;
  final List<BasicCircle> circles;

  @override
  List<Object?> get props => [
        id,
        name,
        circles,
      ];

  GroupWithCircles copyWith({
    Id? id,
    String? name,
    List<BasicCircle>? circles,
  }) {
    return GroupWithCircles(
      id: id ?? this.id,
      name: name ?? this.name,
      circles: circles ?? this.circles,
    );
  }
}

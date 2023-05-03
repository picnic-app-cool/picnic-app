import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

@protected
class SelectableCircleGroup extends Equatable {
  const SelectableCircleGroup({
    required this.groupId,
    required this.groupName,
    required this.circles,
  });

  factory SelectableCircleGroup.fromCircleGroup(GroupWithCircles it) => SelectableCircleGroup(
        groupId: it.id,
        groupName: it.name,
        circles: it.circles.map((circle) => Selectable(item: circle)).toList(),
      );

  final Id groupId;
  final String groupName;
  final List<Selectable<BasicCircle>> circles;

  bool get selected => circles.where((circle) => circle.selected).isNotEmpty;

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        circles,
      ];

  bool get anythingSelected => circles.any((it) => it.selected);

  int get selectionsCount => circles.where((it) => it.selected).length;

  GroupWithCircles toCircleGroup() => GroupWithCircles(
        id: groupId,
        name: groupName,
        circles: circles.map((e) => e.item).toList(),
      );

  SelectableCircleGroup copyWith({
    Id? groupId,
    String? groupName,
    List<Selectable<BasicCircle>>? circles,
  }) {
    return SelectableCircleGroup(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      circles: circles ?? this.circles,
    );
  }

  SelectableCircleGroup byTogglingCircleSelection(BasicCircle circle) => copyWith(
        circles: circles.map(
          (it) {
            return it.item.id == circle.id //
                ? it.copyWith(selected: !it.selected)
                : it;
          },
        ).toList(),
      );

  SelectableCircleGroup byTogglingGroupSelection() {
    final wasSelected = selected;
    var index = 0;
    return copyWith(
      circles: circles.map((it) {
        if (wasSelected || index >= GroupWithCircles.preselectCirclesCount) {
          return it.copyWith(selected: false);
        } else {
          index++;
          return it.copyWith(selected: true);
        }
      }).toList(),
    );
  }
}

extension SelectableCircleGroupList on Iterable<GroupWithCircles> {
  List<SelectableCircleGroup> toSelectableCircleGroupList() =>
      map((it) => SelectableCircleGroup.fromCircleGroup(it)).toList();
}

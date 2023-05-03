import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';

@protected
class SelectableOnBoardingCirclesSection extends Equatable {
  const SelectableOnBoardingCirclesSection({
    required this.circles,
    required this.groupName,
  });

  factory SelectableOnBoardingCirclesSection.fromGroupedCircles(OnboardingCirclesSection groupedCircles) =>
      SelectableOnBoardingCirclesSection(
        circles: groupedCircles.circles.map((circle) => Selectable(item: circle)).toList(),
        groupName: groupedCircles.name,
      );

  final List<Selectable<BasicCircle>> circles;
  final String groupName;

  bool get selected => circles.where((circle) => circle.selected).isNotEmpty;

  @override
  List<Object?> get props => [
        circles,
        groupName,
      ];

  bool get anythingSelected => circles.any((it) => it.selected);

  int get selectionsCount => circles.where((it) => it.selected).length;

  SelectableOnBoardingCirclesSection copyWith({
    List<Selectable<BasicCircle>>? circles,
    String? groupName,
  }) {
    return SelectableOnBoardingCirclesSection(
      circles: circles ?? this.circles,
      groupName: groupName ?? this.groupName,
    );
  }

  SelectableOnBoardingCirclesSection byTogglingCircleSelection(BasicCircle circle) => copyWith(
        circles: circles.map(
          (it) {
            return it.item.id == circle.id //
                ? it.copyWith(selected: !it.selected)
                : it;
          },
        ).toList(),
      );
}

extension OnBoardingCirclesListExtension on List<SelectableOnBoardingCirclesSection> {
  bool get anythingSelected => any((element) => element.anythingSelected);

  int get selectionsCount => fold(0, (prev, elem) => prev + elem.selectionsCount);

  List<SelectableOnBoardingCirclesSection> byTogglingCircleSelection(BasicCircle circle) {
    return map((onBoardingCirclesUiModel) {
      final updatedCirclesGroup = onBoardingCirclesUiModel.copyWith(
        circles: onBoardingCirclesUiModel.byTogglingCircleSelection(circle).circles,
      );
      return updatedCirclesGroup;
    }).toList();
  }

  List<BasicCircle> get selectedCircles => expand(
        (group) => group.circles.where((element) => element.selected),
      )
          .map(
            (selectable) => selectable.item,
          )
          .toList();
}

extension OnBoardingSelectableCirclesSectionsList on Iterable<OnboardingCirclesSection> {
  List<SelectableOnBoardingCirclesSection> toSelectableCirclesSection() =>
      map((it) => SelectableOnBoardingCirclesSection.fromGroupedCircles(it)).toList();
}

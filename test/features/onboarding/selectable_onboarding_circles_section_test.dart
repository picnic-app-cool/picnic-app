import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/onboarding/circles_picker/model/selectable_onboarding_circles_section.dart';
import '../../mocks/stubs.dart';

void main() {
  late List<SelectableOnBoardingCirclesSection> selectableOnboardingCirclesSections;

  test(
    "byTogglingCircleSelection should return different list",
    () {
      final newList = selectableOnboardingCirclesSections
          .byTogglingCircleSelection(selectableOnboardingCirclesSections[0].circles[1].item);
      expect(newList != selectableOnboardingCirclesSections, true);
    },
  );

  test(
    "byTogglingCircleSelection should toggle one circle",
    () {
      final newList = selectableOnboardingCirclesSections.byTogglingCircleSelection(
        selectableOnboardingCirclesSections[0].circles[1].item,
      );
      expect(newList[0].circles[1].selected, true);
      expect(([...newList[0].circles]..removeAt(1)).every((it) => !it.selected), true);
      expect(newList[1].circles.none((it) => it.selected), true);
    },
  );

  test(
    "byTogglingCircleSelection should select and deselect",
    () {
      final group = selectableOnboardingCirclesSections[0];
      final circle = group.circles[1].item;
      final newList = selectableOnboardingCirclesSections //
          .byTogglingCircleSelection(circle)
          .byTogglingCircleSelection(circle);

      expect(newList[0].circles.none((it) => it.selected), true);
      expect(newList[1].circles.none((it) => it.selected), true);
    },
  );

  test(
    "byTogglingCircleSelection should allow multiple selections",
    () {
      final circle1 = selectableOnboardingCirclesSections[0].circles[1].item;
      final circle2 = selectableOnboardingCirclesSections[1].circles[2].item;
      final newList = selectableOnboardingCirclesSections //
          .byTogglingCircleSelection(circle1)
          .byTogglingCircleSelection(circle2);

      expect(newList[0].circles[1].selected, true);
      expect(newList[1].circles[2].selected, true);
    },
  );

  setUp(() {
    selectableOnboardingCirclesSections = Stubs.onBoardingCircles.toSelectableCirclesSection();
  });
}

import 'package:alchemist/alchemist.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/ui/widgets/picnic_countdown.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  late DateTime deadlineIsCome;
  late DateTime deadlineInThreeHours;
  late DateTime deadlineInThreeDays;
  late DateTime deadlineInThreeMonth;

  void _init() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 9, 2));
    deadlineIsCome = Mocks.currentTimeProvider.currentTime;
    deadlineInThreeHours = Mocks.currentTimeProvider.currentTime.add(const Duration(hours: 3));
    deadlineInThreeDays = Mocks.currentTimeProvider.currentTime.add(const Duration(days: 3));
    deadlineInThreeMonth = Mocks.currentTimeProvider.currentTime.add(const Duration(days: 90));
  }

  widgetScreenshotTest(
    'picnic_countdown',
    setUp: _init,
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'deadline is come',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineIsCome,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'deadline in 3 hours',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeHours,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'deadline in 3 days',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeDays,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'deadline in 3 month',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeMonth,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with approve button',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeMonth,
              onTapApprove: () => {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with reject button',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeMonth,
              onTapReject: () => {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with approve and reject button',
          child: TestWidgetContainer(
            child: PicnicCountdown(
              currentTimeProvider: Mocks.currentTimeProvider,
              deadline: deadlineInThreeMonth,
              onTapReject: () => {},
              onTapApprove: () => {},
            ),
          ),
        ),
      ],
    ),
  );
}

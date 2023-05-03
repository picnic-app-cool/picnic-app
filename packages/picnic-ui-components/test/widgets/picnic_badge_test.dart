import 'package:alchemist/alchemist.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_badge',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'count less than 10',
          child: const TestWidgetContainer(
            child: PicnicBadge(
              count: 2,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'count greater than 10',
          child: const TestWidgetContainer(
            child: PicnicBadge(
              count: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_switch',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'large size',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.large,
              onChanged: (value) {},
              value: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'regular size',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: (value) {},
              value: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: (value) {},
              value: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'true and enabled',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: (value) {},
              value: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'true and disabled',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: null,
              value: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'false and enabled',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: (value) {},
              value: false,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'false and disabled',
          child: TestWidgetContainer(
            child: PicnicSwitch(
              color: PicnicTheme.of(context).colors.green,
              size: PicnicSwitchSize.regular,
              onChanged: null,
              value: false,
            ),
          ),
        ),
      ],
    ),
  );
}

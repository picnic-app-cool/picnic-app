import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_action_button',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'action button',
          child: TestWidgetContainer(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: PicnicActionButton(
                icon: Image.asset(Assets.images.edit.path),
                label: 'sample action button',
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

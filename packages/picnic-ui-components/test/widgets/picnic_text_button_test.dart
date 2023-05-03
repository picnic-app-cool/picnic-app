import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_text_button',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'normal text button',
          child: TestWidgetContainer(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: const PicnicTextButton(
                label: 'sample button',
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'leading icon text button',
          child: TestWidgetContainer(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: const PicnicTextButton(
                label: 'sample button',
                leadingIcon: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

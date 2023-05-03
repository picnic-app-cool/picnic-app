import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_text_input',
    widgetBuilder: (context) {
      final suffixIcon = Assets.images.arrowDown.image();
      final prefixIcon = Assets.images.setting.image();

      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'text input',
            child: const PicnicTextInput(),
          ),
          GoldenTestScenario(
            name: 'text input with hint text',
            child: const PicnicTextInput(
              hintText: 'Hint text',
            ),
          ),
          GoldenTestScenario(
            name: 'text input with hint text and label',
            child: const PicnicTextInput(
              hintText: 'Hint text',
              outerLabel: Text('Label text'),
            ),
          ),
          GoldenTestScenario(
            name: 'text input with hint, label and error text',
            child: const PicnicTextInput(
              hintText: 'Hint text',
              outerLabel: Text('Label text'),
              errorText: 'Error text',
            ),
          ),
          GoldenTestScenario(
            name: 'text input with initial value',
            child: const PicnicTextInput(
              hintText: 'Hint text',
              initialValue: 'Initial value',
            ),
          ),
          GoldenTestScenario(
            name: 'text input with suffix',
            child: PicnicTextInput(
              hintText: 'Hint text',
              suffix: suffixIcon,
            ),
          ),
          GoldenTestScenario(
            name: 'text input with prefix',
            child: PicnicTextInput(
              hintText: 'Hint text',
              prefix: prefixIcon,
            ),
          ),
          GoldenTestScenario(
            name: 'text input with maxLines',
            child: const PicnicTextInput(
              hintText: 'Hint text',
              maxLines: 5,
            ),
          ),
          GoldenTestScenario(
            name: 'text input with maxLength',
            child: const PicnicTextInput(
              hintText: 'Hint text',
              maxLength: 100,
            ),
          ),
        ],
      );
    },
  );
}

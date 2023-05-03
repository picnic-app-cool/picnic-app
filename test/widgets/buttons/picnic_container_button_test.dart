import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_container_button.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_container_button",
    widgetBuilder: (context) {
      return GoldenTestScenario(
        name: "Picnic container button",
        child: const TestWidgetContainer(
          child: PicnicContainerButton(
            child: Text("Test"),
          ),
        ),
      );
    },
  );
}

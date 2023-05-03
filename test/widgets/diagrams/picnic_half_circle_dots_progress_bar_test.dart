import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/diagrams/picnic_half_circle_dots_progress_bar.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_half_circle_dots_progress_bar",
    widgetBuilder: (context) {
      return GoldenTestScenario(
        name: "circular progress bar",
        child: const SizedBox(
          height: 163,
          width: 400,
          child: PicnicHalfCircleDotsProgressBar(
            progress: 0.21,
          ),
        ),
      );
    },
  );
}

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_icon_button',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'filled icon button',
          child: TestWidgetContainer(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: PicnicIconButton(
                icon: Assets.images.edit.path,
                color: Colors.white,
                iconColor: Colors.green,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'blurred icon button',
          child: TestWidgetContainer(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: PicnicIconButton(
                icon: Assets.images.edit.path,
                iconColor: Colors.green,
                style: PicnicIconButtonStyle.blurred,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

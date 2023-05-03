import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_melons_count_label.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_melons_count_label',
    widgetBuilder: (context) {
      final theme = PicnicTheme.of(context);

      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'default',
            child: TestWidgetContainer(
              child: PicnicMelonsCountLabel(
                label: 'you have 0 melons',
                prefix: Image.asset(
                  Assets.images.watermelonWhole.path,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'default + pink background',
            child: TestWidgetContainer(
              child: PicnicMelonsCountLabel(
                backgroundColor: theme.colors.pink.shade100,
                label: 'you have 0 melons',
                prefix: Image.asset(
                  Assets.images.watermelonWhole.path,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'default + trailing text button',
            child: TestWidgetContainer(
              child: PicnicMelonsCountLabel(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                backgroundColor: theme.colors.pink.shade100,
                labelStyle: theme.styles.body30,
                label: 'you have 0 melons',
                prefix: Image.asset(
                  Assets.images.watermelonWhole.path,
                  height: 22,
                  fit: BoxFit.contain,
                ),
                suffix: PicnicTextButton(
                  label: 'view seeds',
                  onTap: () {},
                  labelStyle: theme.styles.body30.copyWith(
                    color: theme.colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

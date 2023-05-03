import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_tag",
    widgetBuilder: (context) {
      final theme = PicnicTheme.of(context);
      final styles = theme.styles;
      final colors = theme.colors;
      final blackColor = colors.blackAndWhite.shade900;

      return GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: "filled picnic tag with blur radius",
            child: TestWidgetContainer(
              child: PicnicTag(
                title: '#Startups',
                titleTextStyle: styles.title10.copyWith(color: blackColor),
                prefixIcon: Image.asset(Assets.images.rocket.path),
                suffixIcon: Image.asset(
                  Assets.images.add.path,
                  color: blackColor,
                ),
                backgroundColor: colors.blackAndWhite.shade600,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "filled picnic tag without blur radius",
            child: TestWidgetContainer(
              child: PicnicTag(
                title: '#Startups',
                blurRadius: null,
                titleTextStyle: styles.title10.copyWith(color: blackColor),
                prefixIcon: Image.asset(Assets.images.rocket.path),
                suffixIcon: Image.asset(
                  Assets.images.add.path,
                  color: blackColor,
                ),
                backgroundColor: colors.blackAndWhite.shade600,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "filled picnic tag without icons and without blur radius",
            child: TestWidgetContainer(
              child: PicnicTag(
                title: '#Startups',
                blurRadius: null,
                titleTextStyle: styles.title10.copyWith(color: blackColor),
                backgroundColor: colors.green,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "outlined picnic tag without icons and without blur radius",
            child: TestWidgetContainer(
              child: PicnicTag(
                title: 'gacha',
                style: PicnicTagStyle.outlined,
                blurRadius: null,
                titleTextStyle: styles.title10.copyWith(color: blackColor),
                backgroundColor: colors.blackAndWhite.shade100,
                borderColor: colors.blackAndWhite.shade400,
              ),
            ),
          ),
        ],
      );
    },
  );
}

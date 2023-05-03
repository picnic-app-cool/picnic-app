import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_button',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'small size + filled',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + filled',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              size: PicnicButtonSize.large,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + filled + thin spacing',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              title: 'edit profile',
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + filled + thin spacing',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              size: PicnicButtonSize.large,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + filled + disabled',
          child: const TestWidgetContainer(
            child: PicnicButton(
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + filledd + disabled',
          child: const TestWidgetContainer(
            child: PicnicButton(
              size: PicnicButtonSize.large,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + filled + icon',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              title: 'edit profile',
              icon: Assets.images.edit.path,
              titleColor: PicnicTheme.of(context).colors.blackAndWhite.shade100,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + filled + icon',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              size: PicnicButtonSize.large,
              title: 'edit profile',
              icon: Assets.images.edit.path,
              titleColor: PicnicTheme.of(context).colors.blackAndWhite.shade100,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + outlined',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              borderColor: PicnicTheme.of(context).colors.green,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + outlined',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              borderColor: PicnicTheme.of(context).colors.green,
              size: PicnicButtonSize.large,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + outlined + thin spacing',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              borderColor: PicnicTheme.of(context).colors.green,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + thin spacing',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              borderColor: PicnicTheme.of(context).colors.green,
              size: PicnicButtonSize.large,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + outlined + disabled',
          child: TestWidgetContainer(
            child: PicnicButton(
              borderColor: PicnicTheme.of(context).colors.green,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + outlined + disabled',
          child: TestWidgetContainer(
            child: PicnicButton(
              borderColor: PicnicTheme.of(context).colors.green,
              size: PicnicButtonSize.large,
              style: PicnicButtonStyle.outlined,
              color: Colors.transparent,
              borderWidth: 3,
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'small size + outlined + icon',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              borderColor: PicnicTheme.of(context).colors.green,
              style: PicnicButtonStyle.outlined,
              borderWidth: 3,
              color: PicnicTheme.of(context).colors.blackAndWhite.shade100,
              suffix: Assets.images.edit.image(
                color: PicnicTheme.of(context).colors.green,
              ),
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'large size + outlined + icon',
          child: TestWidgetContainer(
            child: PicnicButton(
              onTap: () {},
              size: PicnicButtonSize.large,
              borderColor: PicnicTheme.of(context).colors.green,
              style: PicnicButtonStyle.outlined,
              borderWidth: 3,
              color: PicnicTheme.of(context).colors.blackAndWhite.shade100,
              suffix: Assets.images.edit.image(
                color: PicnicTheme.of(context).colors.green,
              ),
              titleColor: PicnicTheme.of(context).colors.green,
              title: 'edit profile',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'reduce padding when squeezing',
          child: TestWidgetContainer(
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buttonForWidth(160),
                    _buttonForWidth(150),
                    _buttonForWidth(140),
                    _buttonForWidth(130),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buttonForWidth(double width) => SizedBox(
      width: width,
      child: PicnicButton(
        onTap: () {},
        size: PicnicButtonSize.large,
        title: 'edit profile',
      ),
    );

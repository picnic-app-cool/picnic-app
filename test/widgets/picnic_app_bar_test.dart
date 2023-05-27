import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_app_bar",
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: 'default left icon, no child, no actions',
          child: const TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, very long text child, no actions',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              child: Text(
                'Picnic picnic Picnic picnic Picnic picnic Picnic picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, very long text child, 1 action',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.bell.path,
                ),
              ],
              child: Text(
                'Picnic picnic Picnic picnic Picnic picnic Picnic picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, very long text child, 2 actions',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.bell.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.message.path,
                ),
              ],
              child: Text(
                'Picnic picnic Picnic picnic Picnic picnic Picnic picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, very long text child, 3 actions',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.bell.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.message.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.person.path,
                ),
              ],
              child: Text(
                'Picnic picnic Picnic picnic Picnic picnic Picnic picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, short text child, 1 action',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.bell.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.message.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.person.path,
                ),
              ],
              child: Text(
                'Picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'left icon, short text child, 2 actions',
          child: TestWidgetContainer(
            child: PicnicAppBar(
              showBackButton: true,
              iconPathLeft: Assets.images.close.path,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.bell.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.message.path,
                ),
                PicnicContainerIconButton(
                  iconPath: Assets.images.person.path,
                ),
              ],
              child: Text(
                'Picnic',
                style: PicnicTheme.of(context).styles.subtitle30,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

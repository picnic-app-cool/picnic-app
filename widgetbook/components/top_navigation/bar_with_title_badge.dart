import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_title_badge.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../constants/widgetbook_constants.dart';

class PicnicBarWithTitleBadgeCases extends WidgetbookComponent {
  PicnicBarWithTitleBadgeCases()
      : super(
          name: '$PicnicBarWithTitleBadge',
          useCases: [
            WidgetbookUseCase(
              name: 'Bar with left title and ONE right button WITH badge',
              builder: (context) {
                return PicnicBarWithTitleBadge(
                  title: context.knobs.text(label: 'title', initialValue: 'discover'),
                  iconPathFirst: context.knobs.options(
                    label: 'icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  badgeRadius: context.knobs.number(
                    label: 'badge radius',
                    initialValue: 10.0,
                  ) as double,
                  badgeValue: context.knobs.number(label: 'badge value', initialValue: 1) as int,
                  badgeBackgroundColor: context.knobs.options(
                    label: 'badge background color',
                    options: const [
                      Option<Color>(label: 'red', value: Color(0xFFFF5D7B)),
                      Option<Color>(label: 'green', value: Color(0xFF96E07C)),
                      Option<Color>(label: 'orange', value: Color(0xFFFF9371)),
                    ],
                  ),
                  iconTintColor: context.knobs.options(
                    label: "icon tint color",
                    options: WidgetBookConstants.colorOptionsNullable,
                  ),
                  onTapFirst: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Bar with left title and ONE right button WITHOUT badge',
              builder: (context) {
                return PicnicBarWithTitleBadge(
                  title: context.knobs.text(label: 'title', initialValue: 'discover'),
                  iconPathFirst: context.knobs.options(
                    label: 'icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  iconTintColor: context.knobs.options(
                    label: "icon tint color",
                    options: WidgetBookConstants.colorOptionsNullable,
                  ),
                  onTapFirst: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Bar with left title and TWO right button WITH badge',
              builder: (context) {
                return PicnicBarWithTitleBadge(
                  title: context.knobs.text(label: 'title', initialValue: 'discover'),
                  badgeRadius: context.knobs.number(
                    label: 'badge radius',
                    initialValue: 10.0,
                  ) as double,
                  iconPathFirst: context.knobs.options(
                    label: 'icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  iconPathSecond: context.knobs.options(
                    label: 'icon2',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  onTapSecond: () => {},
                  badgeValue: context.knobs.number(label: 'badge value', initialValue: 1) as int,
                  badgeBackgroundColor: context.knobs.options(
                    label: 'badge background color',
                    options: const [
                      Option<Color>(label: 'red', value: Color(0xFFFF5D7B)),
                      Option<Color>(label: 'green', value: Color(0xFF96E07C)),
                      Option<Color>(label: 'orange', value: Color(0xFFFF9371)),
                    ],
                  ),
                  iconTintColor: context.knobs.options(
                    label: "icon tint color",
                    options: WidgetBookConstants.colorOptionsNullable,
                  ),
                  onTapFirst: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Bar with left title and TWO right button WITHOUT badge',
              builder: (context) {
                return PicnicBarWithTitleBadge(
                  title: context.knobs.text(label: 'title', initialValue: 'discover'),
                  iconPathFirst: context.knobs.options(
                    label: 'icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  iconPathSecond: context.knobs.options(
                    label: 'icon2',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  onTapFirst: () {},
                  onTapSecond: () {},
                );
              },
            )
          ],
        );
}

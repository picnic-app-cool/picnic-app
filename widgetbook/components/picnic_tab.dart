//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTabUseCase extends WidgetbookComponent {
  PicnicTabUseCase()
      : super(
          name: "$PicnicTab",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Tab Use Case",
              builder: (context) => PicnicTab(
                isActive: context.knobs.boolean(label: 'Is Active'),
                iconPath: context.knobs.options(
                  label: 'Icon',
                  options: [
                    Option(
                      label: "Person",
                      value: Assets.images.person.path,
                    ),
                  ],
                ),
                title: context.knobs.text(label: 'Title', initialValue: "posts"),
                badgeCount: context.knobs.options(
                  label: 'Badge',
                  options: [
                    const Option(
                      label: 'No badge',
                      value: null,
                    ),
                    const Option(
                      label: '5',
                      value: 5,
                    ),
                  ],
                ),
                onTap: () => {},
              ),
            ),
          ],
        );
}

//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicSwitchUseCases extends WidgetbookComponent {
  PicnicSwitchUseCases()
      : super(
          name: "$PicnicSwitch",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Switch Use Case",
              builder: (context) {
                final colors = PicnicTheme.of(context).colors;
                return PicnicSwitch(
                  onChanged: context.knobs.options(
                    label: 'onChanged',
                    options: [
                      Option(label: 'Non-null function', value: (value) {}),
                      const Option(label: 'Null function', value: null),
                    ],
                  ),
                  value: context.knobs.boolean(
                    label: 'Value',
                  ),
                  color: context.knobs.options(
                    label: 'Active color',
                    options: [
                      Option(
                        label: "Green",
                        value: colors.green,
                      ),
                    ],
                  ),
                  size: context.knobs.options(
                    label: 'Size',
                    options: [
                      Option(
                        label: "Regular",
                        value: PicnicSwitchSize.regular,
                      ),
                      Option(
                        label: "Small",
                        value: PicnicSwitchSize.small,
                      ),
                      Option(
                        label: "Large",
                        value: PicnicSwitchSize.large,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
}

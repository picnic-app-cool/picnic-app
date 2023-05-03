import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicIconButtonUseCases extends WidgetbookComponent {
  PicnicIconButtonUseCases()
      : super(
          name: "$PicnicIconButton",
          useCases: [
            WidgetbookUseCase(
              name: 'Icon Button Use Cases',
              builder: (context) {
                final themeColors = PicnicTheme.of(context).colors;

                return PicnicIconButton(
                  icon: context.knobs.text(
                    label: 'Button Icon',
                    initialValue: Assets.images.send.path,
                  ),
                  color: context.knobs.options(
                    label: 'Button Color',
                    options: [
                      Option(
                        label: "Pink",
                        value: themeColors.pink,
                      ),
                      Option(
                        label: "Dark Blue",
                        value: themeColors.blue,
                      ),
                      Option(
                        label: "Teal Green",
                        value: themeColors.teal,
                      ),
                      Option(
                        label: "Yellow",
                        value: themeColors.yellow,
                      ),
                      Option(
                        label: "White",
                        value: themeColors.blackAndWhite.shade100,
                      ),
                      Option(
                        label: "Black",
                        value: themeColors.blackAndWhite.shade900,
                      ),
                    ],
                  ),
                  iconColor: context.knobs.options(
                    label: 'Icon Color',
                    options: [
                      Option(
                        label: "White",
                        value: themeColors.blackAndWhite.shade100,
                      ),
                      Option(
                        label: "Black",
                        value: themeColors.blackAndWhite.shade900,
                      ),
                    ],
                  ),
                  iconSize: context.knobs.slider(
                    label: 'Icon Size',
                    initialValue: 22,
                    max: 100,
                    min: 1,
                  ),
                  style: context.knobs.options(
                    label: 'Button Style',
                    options: [
                      const Option(
                        label: 'Filled',
                        value: PicnicIconButtonStyle.filled,
                      ),
                      const Option(
                        label: 'Blurred',
                        value: PicnicIconButtonStyle.blurred,
                      ),
                    ],
                  ),
                  size: context.knobs.slider(
                    label: 'Button Size',
                    initialValue: 50,
                    max: 100,
                    min: 1,
                  ),
                  onTap: () {},
                );
              },
            ),
          ],
        );
}

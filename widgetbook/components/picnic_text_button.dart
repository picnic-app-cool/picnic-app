import 'package:flutter/cupertino.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTextButtonUseCases extends WidgetbookComponent {
  PicnicTextButtonUseCases()
      : super(
          name: "$PicnicTextButton",
          useCases: [
            WidgetbookUseCase(
              name: 'Text Button Use Cases',
              builder: (context) {
                final theme = PicnicTheme.of(context);

                return PicnicTextButton(
                  label: 'text button',
                  labelStyle: TextStyle(
                    fontStyle: context.knobs.options(
                      label: 'Font Style',
                      options: [
                        const Option(
                          label: 'Normal',
                          value: FontStyle.normal,
                        ),
                        const Option(
                          label: 'Italic',
                          value: FontStyle.italic,
                        ),
                      ],
                    ),
                    color: context.knobs.options(
                      label: 'Label Color',
                      options: [
                        Option(
                          label: 'Grey',
                          value: theme.colors.blackAndWhite.shade600,
                        ),
                        Option(
                          label: 'Pink',
                          value: theme.colors.pink,
                        ),
                        Option(
                          label: 'Dark Blue',
                          value: theme.colors.blue,
                        ),
                        Option(
                          label: 'Teal Green',
                          value: theme.colors.teal,
                        ),
                        Option(
                          label: 'Yellow',
                          value: theme.colors.yellow,
                        ),
                        Option(
                          label: 'Black',
                          value: theme.colors.blackAndWhite.shade900,
                        ),
                      ],
                    ),
                    fontWeight: context.knobs.options(
                      label: 'Font Weight',
                      options: [
                        const Option(
                          label: 'Light',
                          value: FontWeight.w300,
                        ),
                        const Option(
                          label: 'Normal',
                          value: FontWeight.normal,
                        ),
                        const Option(
                          label: 'Bold',
                          value: FontWeight.bold,
                        ),
                      ],
                    ),
                    fontSize: context.knobs.slider(
                      label: 'Font Size',
                      initialValue: 12,
                      min: 12,
                      max: 80,
                    ),
                  ),
                  onTap: () {},
                );
              },
            ),
          ],
        );
}

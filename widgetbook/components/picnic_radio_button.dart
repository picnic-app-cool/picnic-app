import 'package:picnic_app/ui/widgets/picnic_radio_button.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicRadioButtonUseCases extends WidgetbookComponent {
  PicnicRadioButtonUseCases()
      : super(
          name: "$PicnicRadioButton",
          useCases: [
            WidgetbookUseCase(
              name: 'Picnic Radio Button Use Cases',
              builder: (context) {
                return PicnicRadioButton(
                  value: context.knobs.text(
                    label: 'Radio Button Value',
                    initialValue: 'Value',
                  ),
                  autoFocus: context.knobs.boolean(
                    label: 'Radio Button Auto Focus',
                  ),
                  groupValue: context.knobs.text(
                    label: 'Radio Button Group Value',
                    initialValue: 'Value',
                  ),
                  label: context.knobs.text(
                    label: 'Radio Button Label',
                    initialValue: 'Radio',
                  ),
                  onChanged: context.knobs.options(
                    label: 'Radio Button State',
                    options: [
                      const Option(
                        label: 'Disabled',
                        value: null,
                      ),
                      Option(
                        label: 'Enabled',
                        value: (value) {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
}

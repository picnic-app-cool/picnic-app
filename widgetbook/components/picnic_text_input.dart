import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTextInputUseCases extends WidgetbookComponent {
  PicnicTextInputUseCases()
      : super(
          name: "$PicnicTextInput",
          useCases: [
            WidgetbookUseCase(
              name: "Text Input Use Cases",
              builder: (context) {
                return PicnicTextInput(
                  errorText: context.knobs.text(
                    label: 'Error Text',
                    initialValue: '',
                  ),
                  hintText: context.knobs.text(
                    label: 'Hint Text',
                    initialValue: 'Hint text',
                  ),
                  outerLabel: Text(
                    context.knobs.text(
                      label: 'Label Text',
                      initialValue: '',
                    ),
                  ),
                  initialValue: context.knobs.nullableText(
                    label: 'Initial Value',
                  ),
                  isLoading: context.knobs.boolean(
                    label: 'Loading State',
                  ),
                  maxLength: context.knobs
                      .nullableNumber(
                        label: 'Max Length',
                        initialValue: 1,
                      )
                      ?.toInt(),
                  maxLines: context.knobs
                      .number(
                        label: 'Max Lines',
                        initialValue: 1,
                      )
                      .toInt(),
                  readOnly: context.knobs.boolean(
                    label: 'ReadOnly',
                  ),
                );
              },
            ),
          ],
        );
}

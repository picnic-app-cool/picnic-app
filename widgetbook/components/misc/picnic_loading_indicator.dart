import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicLoadingIndicatorUseCases extends WidgetbookComponent {
  PicnicLoadingIndicatorUseCases()
      : super(
          name: "$PicnicLoadingIndicator",
          useCases: [
            WidgetbookUseCase(
              name: "PicnicLoadingIndicator",
              builder: (context) {
                return Center(
                  child: PicnicLoadingIndicator(
                    isLoading: context.knobs.boolean(
                      label: "isLoading",
                      initialValue: true,
                    ),
                  ),
                );
              },
            ),
          ],
        );
}

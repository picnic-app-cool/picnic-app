import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/diagrams/picnic_half_circle_dots_progress_bar.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicHalfCircleDotsProgressBarComponent extends WidgetbookComponent {
  PicnicHalfCircleDotsProgressBarComponent()
      : super(
          name: "$PicnicHalfCircleDotsProgressBar",
          useCases: [
            WidgetbookUseCase(
              name: "Default",
              builder: (context) => SizedBox(
                height: 500,
                width: 500,
                child: PicnicHalfCircleDotsProgressBar(
                  startBarRadius: context.knobs
                      .number(
                        label: 'start bar radius',
                        initialValue: 68.5,
                      )
                      .toDouble(),
                  dotRadius: context.knobs
                      .number(
                        label: 'dot radius',
                        initialValue: 3.31,
                      )
                      .toDouble(),
                  dotsSpacing: context.knobs
                      .number(
                        label: 'dots spacing',
                        initialValue: 1.21,
                      )
                      .toDouble(),
                  layers: context.knobs
                      .number(
                        label: 'layers',
                        initialValue: 11,
                      )
                      .toInt(),
                  layersSpacing: context.knobs
                      .number(
                        label: 'layers spacing',
                        initialValue: 1.21,
                      )
                      .toDouble(),
                  progress: context.knobs.slider(
                    label: 'progress',
                    min: 0.0,
                    max: 1.0,
                    initialValue: 0.21,
                  ),
                ),
              ),
            )
          ],
        );
}

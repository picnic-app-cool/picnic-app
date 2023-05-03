import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/animated_endless_rotation.dart';
import 'package:widgetbook/widgetbook.dart';

//ignore: no-magic-number
class AnimatedEndlessRotationUseCases extends WidgetbookComponent {
  AnimatedEndlessRotationUseCases()
      : super(
          name: "$AnimatedEndlessRotation",
          useCases: [
            WidgetbookUseCase(
              name: "Endless Rotation Use Cases",
              builder: (context) {
                return Container(
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: AnimatedEndlessRotation(
                      cycleDuration: Duration(
                        milliseconds: context.knobs
                            .slider(
                              label: "Cycle duration (milliseconds)",
                              min: 100,
                              max: 3000,
                              initialValue: 1500,
                            )
                            .toInt(),
                      ),
                      reverse: context.knobs.boolean(
                        label: "reverse",
                      ),
                      child: context.knobs.options(
                        label: 'Content',
                        options: [
                          const Option<Widget>(
                            label: "Text",
                            value: Text("some"),
                          ),
                          Option<Widget>(
                            label: "Image",
                            value: Assets.images.picnicLogo.image(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
}

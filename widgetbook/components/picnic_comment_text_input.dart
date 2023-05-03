import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_comment_text_input.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicCommentTextInputUseCases extends WidgetbookComponent {
  PicnicCommentTextInputUseCases()
      : super(
          name: "$PicnicCommentTextInput",
          isExpanded: true,
          useCases: [
            WidgetbookUseCase(
              name: "Comment text input use cases",
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.watermelonSkin.path),
                    ),
                  ),
                  child: Center(
                    child: PicnicCommentTextInput(
                      hintText: context.knobs.text(
                        label: 'Comment type',
                        initialValue: "🔥 Some text goes here 🔥",
                      ),
                      isDense: context.knobs.boolean(
                        label: 'Is dense',
                      ),
                      maxLines: context.knobs
                          .nullableNumber(
                            label: 'Max lines',
                            initialValue: 1,
                          )
                          ?.toInt(),
                    ),
                  ),
                );
              },
            )
          ],
        );
}

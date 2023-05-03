import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:picnic_app/ui/widgets/picnic_text_post.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTextPostUseCase extends WidgetbookComponent {
  PicnicTextPostUseCase()
      : super(
          name: "$PicnicTextPost",
          useCases: [
            WidgetbookUseCase(
              name: 'Text Post Use Case',
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PicnicTextPost(
                      text: context.knobs.text(
                        label: 'Description',
                        initialValue:
                            'Omg that midterm was terrible. Blah blah blah blah... Did anyone else think it was bad or was it just me :((',
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
}

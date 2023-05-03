import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_post.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../constants/widgetbook_constants.dart';

class PicnicVerticalPostComponent extends WidgetbookComponent {
  PicnicVerticalPostComponent()
      : super(
          name: "$PicnicVerticalPost",
          useCases: [
            WidgetbookUseCase(
              name: "Text",
              builder: (context) {
                return PicnicVerticalPost.text(
                  footer: context.knobs.text(
                    label: 'Username',
                    initialValue: "Username",
                  ),
                  views: context.knobs.number(label: 'Views', initialValue: 100).toInt(),
                  text: context.knobs.text(
                    label: 'Text',
                    initialValue:
                        "Omg that midterm was terrible. Blah blah blah blah... Did anyone else think it was...",
                  ),
                  gradient: context.knobs.options(
                    label: 'Gradient',
                    description: "Choose between color gradients.",
                    options: [
                      const Option(
                        label: "Blue Linear Gradient",
                        value: WidgetBookConstants.picnicPostGradientBlue,
                      ),
                      const Option(
                        label: "Green Linear Gradient",
                        value: WidgetBookConstants.picnicPostGradientGreen,
                      ),
                      const Option(
                        label: "Gold Linear Gradient",
                        value: WidgetBookConstants.picnicPostGradientGold,
                      ),
                      const Option(
                        label: "Pink Linear Gradient",
                        value: WidgetBookConstants.picnicPostGradientPink,
                      ),
                      const Option(
                        label: "Purple Linear Gradient",
                        value: WidgetBookConstants.picnicPostGradientPurple,
                      ),
                    ],
                  ),
                  onTapView: () {},
                  hideAuthorAvatar: false,
                );
              },
            ),
          ],
        );
}

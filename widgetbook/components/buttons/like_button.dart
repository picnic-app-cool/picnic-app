import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicLikeButtonUseCase extends WidgetbookComponent {
  PicnicLikeButtonUseCase()
      : super(
          name: "$PicnicLikeButton",
          useCases: [
            WidgetbookUseCase(
              name: "Like Button",
              builder: (context) => PicnicLikeButton(
                isLiked: context.knobs.boolean(label: 'isLiked'),
                size: 50,
                onTap: () {},
              ),
            ),
          ],
        );
}

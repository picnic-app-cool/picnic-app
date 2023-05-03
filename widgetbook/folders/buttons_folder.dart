import 'package:widgetbook/widgetbook.dart';

import '../components/buttons/chevron_button.dart';
import '../components/buttons/like_button.dart';

class ButtonsFolder extends WidgetbookFolder {
  ButtonsFolder()
      : super(
          name: "Buttons",
          widgets: [
            ChevronButtonUseCase(),
            PicnicLikeButtonUseCase(),
          ],
        );
}

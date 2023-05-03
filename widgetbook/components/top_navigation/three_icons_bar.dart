import 'package:picnic_app/ui/widgets/top_navigation/picnic_three_icons_bar.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../constants/widgetbook_constants.dart';

class PicnicThreeIconsBarUseCase extends WidgetbookComponent {
  PicnicThreeIconsBarUseCase()
      : super(
          name: '$PicnicThreeIconsBar',
          useCases: [
            WidgetbookUseCase(
              name: 'Three icons bar usecase',
              builder: (context) {
                return PicnicThreeIconsBar(
                  iconPath1: context.knobs.options(label: 'icon 1 path', options: WidgetBookConstants.icons),
                  iconPath2: context.knobs.options(label: 'icon 2 path', options: WidgetBookConstants.icons),
                  iconPath3: context.knobs.options(label: 'icon 3 path', options: WidgetBookConstants.icons),
                  title1: context.knobs.text(label: 'title 1', initialValue: 'chat feed'),
                  title2: context.knobs.text(label: 'title 2', initialValue: 'my circles'),
                  title3: context.knobs.text(label: 'title 3', initialValue: 'dms'),
                );
              },
            ),
          ],
        );
}

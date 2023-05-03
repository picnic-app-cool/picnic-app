import 'package:picnic_app/ui/widgets/buttons/picnic_chevron_button.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../constants/widgetbook_constants.dart';

class ChevronButtonUseCase extends WidgetbookComponent {
  ChevronButtonUseCase()
      : super(
          name: "$PicnicChevronButton",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Bottom Navigation Use Case",
              builder: (context) => PicnicChevronButton(
                emoji: context.knobs.options(
                  label: 'Emoji',
                  options: WidgetBookConstants.emojiList,
                ),
                label: context.knobs.text(label: "Button label"),
                onTap: () {},
              ),
            ),
          ],
        );
}

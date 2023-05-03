import 'package:widgetbook/widgetbook.dart';

import '../components/text/empty_message_widget.dart';
import '../components/text/picnic_columned_text_link.dart';
import '../components/text/picnic_markdown_text.dart';

class TextsFolder extends WidgetbookFolder {
  TextsFolder()
      : super(
          name: "Texts",
          widgets: [
            PicnicColumnedTextLinkComponent(),
            EmptyMessageWidgetComponent(),
            PicnicMarkdownTextComponent(),
          ],
        );
}

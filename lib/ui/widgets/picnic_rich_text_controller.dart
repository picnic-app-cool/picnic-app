import 'package:flutter/widgets.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';

class PicnicRichTextController extends TextEditingController {
  PicnicRichTextController({
    this.onMatchChanged,
    String? text,
  }) : super(text: text);

  final ValueChanged<List<String>>? onMatchChanged;

  Map<String, TextStyle> textStyleMatcher = {};

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final children = <TextSpan>[];
    final matches = <String>[];
    final emojiToCharacter = <String, String>{};

    final regExp = RegExp(textStyleMatcher.keys.join('|'));

    text.unemojify(emojiToCharacter).splitMapJoin(
      regExp,
      onNonMatch: (String text) {
        children.add(TextSpan(text: text.emojify(emojiToCharacter), style: style));
        return '';
      },
      onMatch: (Match match) {
        final matchedText = match[0];
        if (textStyleMatcher.isEmpty || matchedText == null) {
          return '';
        }

        final matchKey = textStyleMatcher.entries.firstWhere((pair) {
          return pair.key.allMatches(matchedText).isNotEmpty;
        }).key;

        children.add(TextSpan(text: matchedText, style: textStyleMatcher[matchKey]));

        if (!matches.contains(matchedText)) {
          matches.add(matchedText);
        }

        return '';
      },
    );

    onMatchChanged?.call(matches);

    return TextSpan(style: style, children: children);
  }
}

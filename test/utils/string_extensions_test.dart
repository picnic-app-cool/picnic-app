import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';

void main() {
  final inputsToExpected = {
    '😀': true,
    '🫡 ': true,
    '😀 🤦🏽 😀': true,
    '  😀 😀🤦🏽😀 ': true,
    'text😀': false,
    '😀text': false,
    'text😀te🤦🏽xt': false,
  };

  inputsToExpected.forEach((input, expected) {
    test("hasOnlyEmojis returns $expected when content is: [$input]", () {
      final value = input.hasOnlyEmojis();
      expect(value, expected);
    });
  });

  test("unemojify returns String without emojis & emojify returns String with emojis again", () {
    const text = '😀text🔥text text🤦🏽 text 9🙂🎅🏻🙂9🔥😀';
    final emojiToCharacter = <String, String>{};
    final value = text.unemojify(emojiToCharacter);
    expect(value.emojify(emojiToCharacter), text);
  });

  test("getEmojis returns correct list of emojis from String", () {
    final expected = ['🤦🏽', '🎅🏻', '😀', '👩🏽', '🫡'];
    const text = 'te🤦🏽st tes🎅🏻t test test 😀 t 👩🏽es🫡t';
    final value = text.getEmojis();
    expect(value, expected);
  });
}

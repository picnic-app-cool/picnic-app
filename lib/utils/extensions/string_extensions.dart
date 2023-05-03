import 'package:flutter_emoji/flutter_emoji.dart';

bool isNullOrEmptyString(dynamic object) {
  return object == null || (object is String && object.isEmpty);
}

extension StringExtensions on String {
  static EmojiParser? _emojiParser;

  EmojiParser _getEmojiParser() => _emojiParser ??= EmojiParser();

  bool hasOnlyEmojis() {
    final emojis = getEmojis();
    if (emojis.isEmpty) {
      return false;
    }
    var text = this;
    emojis.toSet().forEach((emoji) => text = text.replaceAll(emoji, ''));
    return text.trim().isEmpty;
  }

  int countEmojis() => getEmojis().length;

  String unemojify([Map<String, String>? emojiToCharacter]) {
    if (emojiToCharacter == null) {
      return _getEmojiParser().unemojify(this);
    }
    var text = this;
    getEmojis().toSet().forEach((emoji) {
      final anyOtherChar = text.anyOtherChar();
      emojiToCharacter[emoji] = anyOtherChar;
      text = text.replaceAll(emoji, anyOtherChar);
    });
    return text;
  }

  String emojify([Map<String, String>? emojiToCharacter]) {
    if (emojiToCharacter == null) {
      return _getEmojiParser().emojify(this);
    }
    var text = this;
    for (final e in emojiToCharacter.entries) {
      text = text.replaceAll(e.value, e.key);
    }
    return text;
  }

  List<String> getEmojis() {
    final pattern = RegExp(r'(\p{Emoji_Modifier_Base}\p{Emoji_Modifier}*)|(\p{Extended_Pictographic})', unicode: true);
    final matches = pattern.allMatches(this);
    return matches.map((match) => match.group(0)!).toList();
  }

  String anyOtherChar() {
    const count = 256;
    final chars = split('').toSet();
    return String.fromCharCode(
      Iterable<int>.generate(count)
          .firstWhere((code) => !chars.contains(String.fromCharCode(code)), orElse: () => count),
    );
  }
}

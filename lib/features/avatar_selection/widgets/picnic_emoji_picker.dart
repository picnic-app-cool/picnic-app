import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicEmojiPicker extends StatelessWidget {
  const PicnicEmojiPicker({
    Key? key,
    required this.onEmojiSelected,
  }) : super(key: key);

  final Function(String) onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackColor = colors.blackAndWhite.shade900;
    final greyColor = colors.blackAndWhite.shade600;

    return isUnitTests
        ? const SizedBox.shrink()
        : EmojiPicker(
            onEmojiSelected: (category, emoji) => onEmojiSelected(emoji.emoji),
            config: Config(
              iconColor: greyColor,
              iconColorSelected: blackColor,
              indicatorColor: blackColor,
            ),
          );
  }
}

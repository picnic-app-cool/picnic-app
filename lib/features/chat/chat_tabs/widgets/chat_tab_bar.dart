import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/chat_tabs/widgets/chat_button.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatTabBar extends StatelessWidget {
  const ChatTabBar({
    Key? key,
    required this.onTap,
    required this.selectedType,
  }) : super(key: key);

  final Function(ChatTabType) onTap;
  final ChatTabType selectedType;

  static const double kIconSize = 18;
  static const double kColorOpacity = 0.6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final normalTitleStyle = theme.styles.body20;
    final selectedTitleStyle = theme.styles.subtitle20;
    final colors = theme.colors;
    final normalColor = colors.darkBlue.withOpacity(kColorOpacity);
    final selectedColor = colors.darkBlue.shade800;
    final normalStyle = normalTitleStyle.copyWith(color: normalColor);
    final selectedStyle = selectedTitleStyle.copyWith(color: selectedColor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ChatTabType.values
            .sortedBy<num>((type) => type.stackIndex)
            .map(
              (type) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChatButton(
                    type: type,
                    onTap: () => onTap(type),
                    labelStyle: selectedType == type ? selectedStyle : normalStyle,
                    leadingIcon: ImageIcon(
                      AssetImage(type.iconKey),
                      color: selectedType == type ? selectedColor : normalColor,
                      size: kIconSize,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

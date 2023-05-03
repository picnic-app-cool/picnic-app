import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicColorSelectionItem extends StatelessWidget {
  const PicnicColorSelectionItem({
    Key? key,
    required this.textColor,
    this.isSelected = false,
    this.itemSize,
    this.ringWidth,
    required this.onColorSelected,
  }) : super(key: key);

  final TextColor textColor;
  final bool isSelected;
  final double? itemSize;
  final double? ringWidth;
  final ValueChanged<TextColor> onColorSelected;

  static const double _defaultItemSize = 64;

  @override
  Widget build(BuildContext context) {
    final size = itemSize ?? _defaultItemSize;

    return InkResponse(
      onTap: () => onColorSelected(textColor),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: textColor.color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isSelected ? Image.asset(Assets.images.done.path) : null,
        ),
      ),
    );
  }
}

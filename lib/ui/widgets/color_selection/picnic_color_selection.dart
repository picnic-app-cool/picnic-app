import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/ui/widgets/color_selection/picnic_color_selection_item.dart';

class PicnicColorSelection extends StatefulWidget {
  PicnicColorSelection({
    Key? key,
    this.itemSize,
    this.ringWidth,
    required this.options,
    required this.onColorTextSelected,
    required this.selectedTextColor,
  })  : assert(
          options.isNotEmpty,
          'options should not be empty',
        ),
        super(key: key);

  final ValueChanged<TextColor> onColorTextSelected;
  final List<TextColor> options;
  final TextColor selectedTextColor;
  final double? itemSize;
  final double? ringWidth;

  @override
  State<PicnicColorSelection> createState() => _PicnicColorSelectionState();
}

class _PicnicColorSelectionState extends State<PicnicColorSelection> {
  late TextColor _selectedColor;

  @override
  void initState() {
    _selectedColor = widget.selectedTextColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          padding: const EdgeInsets.only(bottom: 16.0),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 26.0,
          ),
          itemCount: widget.options.length,
          itemBuilder: (_, index) {
            final textColor = widget.options[index];

            return PicnicColorSelectionItem(
              onColorSelected: _updateSelectedTextColor,
              textColor: textColor,
              isSelected: _selectedColor == textColor,
              itemSize: widget.itemSize,
              ringWidth: widget.ringWidth,
            );
          },
        ),
        const Divider(),
      ],
    );
  }

  void _updateSelectedTextColor(TextColor color) {
    setState(() {
      _selectedColor = color;
    });
    widget.onColorTextSelected(color);
  }
}

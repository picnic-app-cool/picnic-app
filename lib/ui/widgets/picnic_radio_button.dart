import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

class PicnicRadioButton<T> extends StatelessWidget {
  const PicnicRadioButton({
    Key? key,
    required this.value,
    this.onChanged,
    this.label = '',
    this.groupValue,
    this.autoFocus = false,
  }) : super(key: key);

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String label;
  final bool autoFocus;

  static const double _labelBottomPadding = 1;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final selected = value == groupValue;
    final color = _fillColor(
      context,
      theme,
      selected,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: MaterialStateProperty.all(color),
          groupValue: groupValue,
          onChanged: onChanged,
          autofocus: autoFocus,
          activeColor: theme.colors.blue,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: _labelBottomPadding,
            ),
            child: AnimatedDefaultTextStyle(
              duration: const ExtraShortDuration(),
              curve: Curves.easeIn,
              style: theme.styles.body30.copyWith(
                color: color,
              ),
              child: Text(
                label,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _fillColor(
    BuildContext context,
    PicnicThemeData theme,
    bool selected,
  ) {
    final blackAndWhite = theme.colors.blackAndWhite;
    return onChanged == null
        ? blackAndWhite
        : selected
            ? theme.colors.blue
            : blackAndWhite.shade600;
  }
}

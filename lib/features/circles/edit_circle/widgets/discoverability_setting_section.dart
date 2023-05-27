import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DiscoverabilitySettingSection extends StatelessWidget {
  const DiscoverabilitySettingSection({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.description,
  }) : super(key: key);

  final CircleVisibility value;
  final CircleVisibility groupValue;
  final ValueChanged<CircleVisibility> onChanged;
  final String label;
  final String description;

  static const double _activeBorderWidth = 2;
  static const double _inactiveBorderWidth = 1;
  static const double _activeBackgroundColorOpacity = 0.1;
  static const double _borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final blackAndWhite = colors.blackAndWhite;
    final blue = colors.blue;
    final subTitleTextStyle = styles.caption10.copyWith(color: blackAndWhite.shade600);
    final isActive = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(_borderRadius),
      child: AnimatedContainer(
        duration: const ExtraShortDuration(),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: isActive ? blue : blackAndWhite.shade300,
            width: isActive ? _activeBorderWidth : _inactiveBorderWidth,
          ),
          color: isActive ? blue.withOpacity(_activeBackgroundColorOpacity) : null,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: styles.subtitle30,
            ),
            Text(
              description,
              style: subTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

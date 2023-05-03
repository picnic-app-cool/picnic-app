import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class BlockWidget extends StatelessWidget {
  const BlockWidget({super.key, required this.child});

  final Widget child;

  static const double _shadowOpacity = 0.05;
  static const double _blurRadius = 30;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.blackAndWhite.shade100,
        border: Border.all(color: colors.blackAndWhite.shade300),
        borderRadius: BorderRadius.circular(
          Constants.borderRadiusL,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            color: colors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.lowPadding,
        ),
        child: child,
      ),
    );
  }
}

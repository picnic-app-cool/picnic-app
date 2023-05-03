import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class DecoratedSheet extends StatelessWidget {
  const DecoratedSheet({
    Key? key,
    required this.child,
    required this.onTap,
    required this.buttonTitle,
    this.flex = 1,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final String buttonTitle;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: blackAndWhite.shade100,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: flex, child: child),
              Row(
                children: [
                  Expanded(
                    child: PicnicButton(
                      title: buttonTitle,
                      onTap: onTap,
                    ),
                  ),
                ],
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}

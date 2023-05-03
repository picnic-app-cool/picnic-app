import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicChevronButton extends StatelessWidget {
  const PicnicChevronButton({
    Key? key,
    required this.label,
    this.buttonEnabled = true,
    this.emoji,
    this.imagePath,
    this.trailingWidget,
    this.padding = EdgeInsets.zero,
    this.onTap,
  }) : super(key: key);

  final String? imagePath;
  final String? emoji;
  final String label;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Widget? trailingWidget;
  final bool buttonEnabled;

  static const disabledOpacity = 0.5;
  static const enabledOpacity = 1.0;
  static const double _chevronSize = 20;
  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final _theme = PicnicTheme.of(context);
    final _styleBody30 = _theme.styles.body30;

    return Opacity(
      opacity: (onTap == null || !buttonEnabled) ? disabledOpacity : enabledOpacity,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath!,
                  width: _iconSize,
                ),
                const Gap(6),
              ],
              if (emoji != null) ...[
                Text(
                  emoji!,
                  style: _styleBody30.copyWith(fontSize: Constants.emojiSize),
                ),
                const Gap(6),
              ],
              Expanded(
                child: Row(
                  children: [
                    Text(
                      label,
                      style: _styleBody30,
                    ),
                    if (trailingWidget != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: trailingWidget,
                      ),
                  ],
                ),
              ),
              const Gap(6),
              Image.asset(
                Assets.images.arrowRight.path,
                width: _chevronSize,
                height: _chevronSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

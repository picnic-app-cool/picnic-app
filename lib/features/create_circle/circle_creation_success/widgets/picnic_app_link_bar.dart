import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicAppLinkBar extends StatelessWidget {
  const PicnicAppLinkBar({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  static const imageScale = 4.0;
  static const borderRadius = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: blackAndWhite.shade200,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: theme.styles.caption10.copyWith(color: blackAndWhite.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                Assets.images.changeLink.path,
                color: blackAndWhite.shade600,
                scale: imageScale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

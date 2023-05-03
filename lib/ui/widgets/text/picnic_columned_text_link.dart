import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicColumnedTextLink extends StatelessWidget {
  const PicnicColumnedTextLink({
    Key? key,
    required this.text,
    required this.onTapShareCircleLink,
  }) : super(key: key);

  final String text;

  final VoidCallback onTapShareCircleLink;

  @override
  Widget build(BuildContext context) {
    final picnicTheme = PicnicTheme.of(context);

    final colors = picnicTheme.colors;
    final textTheme = picnicTheme.styles;

    final darkBlueShade500 = colors.darkBlue.shade500;

    return InkWell(
      onTap: onTapShareCircleLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: textTheme.title30.copyWith(
              color: const Color(0xFF45BAEC),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.images.link.path,
                color: darkBlueShade500,
              ),
              const Gap(4),
              Text(
                appLocalizations.linkTabAction,
                style: textTheme.title10.copyWith(
                  color: darkBlueShade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

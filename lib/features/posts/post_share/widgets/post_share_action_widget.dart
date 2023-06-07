import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostShareActionWidget extends StatelessWidget {
  const PostShareActionWidget({
    required this.title,
    required this.assetPath,
    Key? key,
  }) : super(key: key);

  final String title;
  final String assetPath;
  static const double _appAssetSize = 52;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final titleStyle = theme.styles.body0.copyWith(
      color: theme.colors.darkBlue.shade700,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetPath,
          width: _appAssetSize,
          height: _appAssetSize,
        ),
        const Gap(4),
        Text(
          title,
          style: titleStyle,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatProfileBar extends StatelessWidget {
  const ChatProfileBar({
    Key? key,
    required this.onTapProfile,
    required this.onTapSearch,
  }) : super(key: key);

  final VoidCallback onTapProfile;
  final VoidCallback onTapSearch;

  static const double kIconSize = 18;

  @override
  Widget build(BuildContext context) {
    const spacing16 = 16.0;
    final colors = PicnicTheme.of(context).colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Gap(spacing16),
        InkWell(
          onTap: onTapSearch,
          child: ImageIcon(
            AssetImage(Assets.images.search.keyName),
            color: colors.darkBlue,
            size: kIconSize,
          ),
        ),
        const Gap(spacing16),
        InkWell(
          onTap: onTapProfile,
          child: ImageIcon(
            AssetImage(Assets.images.profile.keyName),
            color: colors.darkBlue,
            size: kIconSize,
          ),
        ),
      ],
    );
  }
}

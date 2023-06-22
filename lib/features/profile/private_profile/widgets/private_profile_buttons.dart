import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PrivateProfileButtons extends StatelessWidget {
  const PrivateProfileButtons({
    Key? key,
    required this.onTapEditProfile,
    required this.onTapCreatePosts,
    required this.onTapLinkSocialAccounts,
  }) : super(key: key);

  final VoidCallback onTapEditProfile;
  final VoidCallback onTapCreatePosts;
  final VoidCallback onTapLinkSocialAccounts;

  static const _buttonsHeight = 56.0;
  static const _iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final darkBlue = theme.colors.darkBlue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: PicnicButton(
              title: appLocalizations.createPost,
              onTap: onTapCreatePosts,
              minWidth: double.infinity,
              color: theme.colors.blue,
              titleColor: theme.colors.blackAndWhite.shade100,
            ),
          ),
          const Gap(8),
          InkWell(
            onTap: onTapEditProfile,
            child: Container(
              width: _buttonsHeight,
              height: _buttonsHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue.shade300,
              ),
              child: Image.asset(
                Assets.images.editUnderlined.path,
                color: darkBlue.shade800,
              ),
            ),
          ),
          const Gap(8),
          InkWell(
            onTap: onTapLinkSocialAccounts,
            child: Container(
              width: _buttonsHeight,
              height: _buttonsHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue.shade300,
              ),
              child: Image.asset(
                Assets.images.linkIcon.path,
                color: darkBlue.shade800,
                width: _iconSize,
                height: _iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

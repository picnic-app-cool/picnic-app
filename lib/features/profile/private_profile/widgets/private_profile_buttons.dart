import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PrivateProfileButtons extends StatelessWidget {
  const PrivateProfileButtons({
    Key? key,
    required this.onTapEditProfile,
    required this.onTapCreatePosts,
  }) : super(key: key);

  final VoidCallback onTapEditProfile;
  final VoidCallback onTapCreatePosts;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final whiteColor = theme.colors.blackAndWhite.shade100;

    final darkBlue = theme.colors.darkBlue;
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 4,
            ),
            child: PicnicButton(
              title: appLocalizations.privateProfileEditButton,
              onTap: onTapEditProfile,
              minWidth: double.infinity,
              color: darkBlue.shade300,
              titleColor: darkBlue.shade800,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 4,
            ),
            child: PicnicButton(
              title: appLocalizations.createPost,
              onTap: onTapCreatePosts,
              minWidth: double.infinity,
              color: theme.colors.blue.shade500,
              titleColor: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

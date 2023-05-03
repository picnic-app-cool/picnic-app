import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class NewSeedPage extends StatelessWidget {
  const NewSeedPage({
    Key? key,
  }) : super(key: key);

  static const double _avatarSize = 44.0;
  static const double _imageSize = 42.0;
  static const int _seeds = 14;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    return Scaffold(
      body: Center(
        child: PicnicDialog(
          image: CircleAvatar(
            radius: _avatarSize,
            backgroundColor: colors.blackAndWhite[300],
            child: Image.asset(
              Assets.images.seed.path,
              width: _imageSize,
              fit: BoxFit.contain,
            ),
          ),
          title: appLocalizations.newSeedsTitle(_seeds),
          description: appLocalizations.newSeedsDescription(_seeds),
          content: PicnicButton(
            title: appLocalizations.newSeedAction,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: colors.blue.shade200,
    );
  }
}

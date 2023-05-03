import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class InfoSeedPage extends StatelessWidget {
  const InfoSeedPage({
    Key? key,
  }) : super(key: key);

  static const _backgroundOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PicnicDialog(
          title: appLocalizations.seedsInfoTitle,
          description: appLocalizations.seedsInfoDescription,
          content: PicnicButton(
            title: appLocalizations.seedsDoneAction,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: PicnicTheme.of(context).colors.lightBlue[200]?.withOpacity(_backgroundOpacity),
    );
  }
}

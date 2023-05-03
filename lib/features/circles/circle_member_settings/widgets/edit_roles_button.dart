import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class EditRolesButton extends StatelessWidget {
  const EditRolesButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final purple = colors.purple;
    final white = colors.blackAndWhite.shade100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: PicnicButton(
          title: appLocalizations.editRoles,
          onTap: onTap,
          borderColor: purple,
          color: purple,
          icon: Assets.images.edit.path,
          titleColor: white,
          borderWidth: _borderWidth,
        ),
      ),
    );
  }
}

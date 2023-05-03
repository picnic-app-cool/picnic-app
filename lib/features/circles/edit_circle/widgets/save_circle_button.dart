import 'package:flutter/material.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SaveCircleButton extends StatelessWidget {
  const SaveCircleButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  static const _floatingButtonPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    return Padding(
      padding: EdgeInsets.only(
        left: _floatingButtonPadding,
        right: _floatingButtonPadding,
        bottom: bottomNavBarHeight,
      ),
      child: PicnicButton(
        onTap: onTap,
        title: appLocalizations.editCircleButtonLabel,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
      ),
    );
  }
}

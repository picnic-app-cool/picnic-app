import 'package:flutter/material.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required this.creatingInProgress,
    required this.onTap,
    required this.title,
  });

  final bool creatingInProgress;
  final VoidCallback? onTap;
  final String title;
  static const _floatingButtonPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    return creatingInProgress
        ? const PicnicLoadingIndicator()
        : Padding(
            padding: EdgeInsets.only(
              left: _floatingButtonPadding,
              right: _floatingButtonPadding,
              bottom: bottomNavBarHeight,
            ),
            child: PicnicButton(
              onTap: onTap,
              title: title,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
            ),
          );
  }
}

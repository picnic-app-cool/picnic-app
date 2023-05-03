import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ModUserConfirmButton extends StatelessWidget {
  const ModUserConfirmButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: PicnicButton(
              title: title,
              onTap: onTap,
              color: PicnicTheme.of(context).colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}

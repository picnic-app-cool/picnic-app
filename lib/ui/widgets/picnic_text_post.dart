//ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicTextPost extends StatelessWidget {
  const PicnicTextPost({Key? key, required this.text}) : super(key: key);
  final String text;
  static const borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final whiteColor = blackAndWhite.shade100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFFFF91AB),
              Color(0XFFF4779D),
              Color(0XFFFE9FC1),
            ],
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: theme.styles.body20.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}

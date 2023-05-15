import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodTag extends StatelessWidget {
  const PodTag({
    super.key,
    required this.title,
  });

  final String title;

  static const double _radius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return PicnicTag(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      borderRadius: _radius,
      title: title,
      backgroundColor: theme.colors.lightBlue.shade300,
      titleTextStyle: theme.styles.body20.copyWith(
        color: const Color.fromRGBO(
          29,
          119,
          255,
          1,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleAction extends StatelessWidget {
  const CircleAction({
    Key? key,
    required this.onTap,
    required this.title,
    required this.trailing,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String title;
  final Widget trailing;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final picnicTheme = PicnicTheme.of(context);
    final colors = picnicTheme.colors;
    final textTheme = picnicTheme.styles;
    final shade900 = colors.blackAndWhite.shade900;

    final white = colors.blackAndWhite.shade100;
    final title30Black = textTheme.subtitle40.copyWith(
      color: shade900,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PicnicListItem(
        title: title,
        onTap: onTap,
        borderRadius: _borderRadius,
        titleStyle: title30Black,
        fillColor: white,
        setBoxShadow: true,
        trailing: trailing,
      ),
    );
  }
}

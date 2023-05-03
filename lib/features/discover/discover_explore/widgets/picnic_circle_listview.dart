import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/ui/widgets/picnic_square.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCircleListView extends StatelessWidget {
  const PicnicCircleListView({
    Key? key,
    required this.items,
    required this.onTapViewCircle,
  }) : super(key: key);

  final List<Circle> items;
  final Function(Id) onTapViewCircle;
  static const _paddingValue = 8.0;
  static const _paddingValueFull = 16.0;
  static const _highPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return SizedBox(
      height: PicnicSquare.height + _paddingValueFull,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final circle = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: _paddingValue),
            child: PicnicSquare(
              onTapEnterCircle: () => onTapViewCircle(circle.id),
              emoji: circle.emoji,
              imagePath: circle.imageFile,
              title: circle.name,
              avatarBackgroundColor: colors.blackAndWhite.shade200,
              titleStyle: styles.body20,
            ),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: _highPadding, vertical: _paddingValue),
        itemCount: items.length,
      ),
    );
  }
}

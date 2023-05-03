import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/model/selectable_circle_group.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

typedef CircleClickCallback = void Function(
  Selectable<BasicCircle> circle,
  SelectableCircleGroup group,
);

class CircleGroupingsList extends StatelessWidget {
  const CircleGroupingsList({
    Key? key,
    required this.circleGroups,
    required this.onTapCircleGrouping,
    required this.onTapCircle,
    this.padding = _defaultPadding,
  }) : super(key: key);

  final List<SelectableCircleGroup> circleGroups;
  final ValueChanged<SelectableCircleGroup> onTapCircleGrouping;
  final CircleClickCallback onTapCircle;
  final EdgeInsets padding;

  static const EdgeInsets _defaultPadding = EdgeInsets.symmetric(
    horizontal: 24,
  );
  static const _tagSpacing = 8.0;
  static const _tagBorderRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Padding(
      padding: padding,
      child: Wrap(
        spacing: _tagSpacing,
        runSpacing: _tagSpacing,
        children: circleGroups.expandIndexed(
          (index, group) {
            final tag = PicnicTag(
              onTap: () => onTapCircleGrouping(group),
              title: group.groupName,
              suffixIcon: group.selected
                  ? Image.asset(
                      Assets.images.checkboxCircle.path,
                      color: theme.colors.blackAndWhite.shade100,
                    )
                  : null,
              backgroundColor: _selectColor(theme, index),
              blurRadius: null,
              borderRadius: _tagBorderRadius,
            );
            return [
              tag,
              if (group.selected) ...[
                const SizedBox(width: double.infinity),
                Wrap(
                  spacing: _tagSpacing,
                  runSpacing: _tagSpacing,
                  children: group.circles
                      .map(
                        (it) => _CircleTagWidget(
                          circle: it,
                          circleGroup: group,
                          onTapCircle: onTapCircle,
                        ),
                      )
                      .toList(),
                ),
              ],
            ];
          },
        ).toList(),
      ),
    );
  }

  List<Color> _tagColors(PicnicThemeData theme) => <MaterialColor>[
        theme.colors.teal,
        theme.colors.blue,
        theme.colors.yellow,
        theme.colors.pink,
      ];

  Color _selectColor(PicnicThemeData theme, int index) {
    final colors = _tagColors(theme);
    return colors[index % colors.length];
  }
}

class _CircleTagWidget extends StatelessWidget {
  const _CircleTagWidget({
    Key? key,
    required this.circle,
    required this.circleGroup,
    required this.onTapCircle,
  }) : super(key: key);

  final Selectable<BasicCircle> circle;
  final SelectableCircleGroup circleGroup;

  final CircleClickCallback onTapCircle;

  @override
  //TODO
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return PicnicTag(
      onTap: () => onTapCircle(circle, circleGroup),
      title: circle.item.name,
      titleTextStyle: theme.styles.title10.copyWith(
        color: blackAndWhite.shade900,
      ),
      suffixIcon: circle.selected
          ? Image.asset(
              Assets.images.checkboxCircle.path,
              color: theme.colors.teal,
            )
          : null,
      style: PicnicTagStyle.outlined,
      borderColor: blackAndWhite.shade300,
      borderWidth: 1,
      blurRadius: null,
      borderRadius: CircleGroupingsList._tagBorderRadius,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/onboarding/circles_picker/model/selectable_onboarding_circles_section.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class GroupOfSelectableCircles extends StatelessWidget {
  const GroupOfSelectableCircles({
    required this.selectableGroupedCircles,
    required this.groupIndex,
    required this.onTapCircle,
  });

  final SelectableOnBoardingCirclesSection selectableGroupedCircles;
  final int groupIndex;
  final void Function(Selectable<BasicCircle> circle) onTapCircle;
  static const _spacingBetweenCircles = 8.0;
  static const _circleRadius = 100.0;
  static const _emojiSize = 18.0;
  static const _avatarSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final color = _getColor(colors);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectableGroupedCircles.groupName,
          style: styles.subtitle20,
        ),
        const Gap(13),
        Wrap(
          spacing: _spacingBetweenCircles,
          runSpacing: _spacingBetweenCircles,
          children: selectableGroupedCircles.circles.map((selectableCircle) {
            final circle = selectableCircle.item;
            final circleImage = circle.imageFile;
            final prefixImage = circleImage.isNotEmpty
                ? PicnicCircleAvatar(
                    image: circleImage,
                    emoji: circle.emoji,
                    avatarSize: _avatarSize,
                    emojiSize: _emojiSize,
                  )
                : null;
            final prefixEmoji = circleImage.isEmpty ? '${circle.emoji} ' : '';
            return PicnicTag(
              onTap: () => onTapCircle(selectableCircle),
              title: '$prefixEmoji${circle.name}',
              titleTextStyle: styles.body20.copyWith(
                color: selectableCircle.selected ? colors.blackAndWhite.shade100 : colors.blackAndWhite.shade900,
              ),
              prefixIcon: prefixImage,
              suffixIcon: selectableCircle.selected
                  ? Image.asset(
                      Assets.images.checkboxCircle.path,
                      color: Colors.white,
                    )
                  : null,
              style: PicnicTagStyle.outlined,
              backgroundColor: selectableCircle.selected ? color : Colors.white,
              borderColor: color,
              borderWidth: 1,
              blurRadius: null,
              borderRadius: _circleRadius,
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getColor(PicnicColors colors) {
    final colorsList = _colorsList(colors);
    return colorsList[groupIndex % colorsList.length];
  }

  List<Color> _colorsList(PicnicColors colors) => <MaterialColor>[
        colors.blue,
        colors.pink,
        colors.green,
        colors.blackAndWhite,
        colors.yellow,
      ];
}

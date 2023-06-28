import 'package:flutter/material.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class InterestsSelectionSection extends StatelessWidget {
  const InterestsSelectionSection({
    required this.selectableInterests,
    required this.onTapInterest,
  });

  final List<Selectable<Interest>> selectableInterests;
  final void Function(Selectable<Interest> circle) onTapInterest;
  static const _spacingBetweenInterests = 8.0;
  static const _interestRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final unSelectedTextStyle = styles.body20.copyWith(color: darkBlue.shade800);
    final selectedTextStyle = styles.subtitle20.copyWith(color: darkBlue.shade900);

    return Wrap(
      spacing: _spacingBetweenInterests,
      runSpacing: _spacingBetweenInterests,
      children: selectableInterests.map((selectableInterest) {
        final interest = selectableInterest.item;
        final prefixEmoji = interest.emoji.isNotEmpty ? '${interest.emoji} ' : '';
        return PicnicTag(
          onTap: () => onTapInterest(selectableInterest),
          title: '$prefixEmoji${interest.name}',
          titleTextStyle: selectableInterest.selected ? selectedTextStyle : unSelectedTextStyle,
          style: PicnicTagStyle.outlined,
          backgroundColor: selectableInterest.selected ? colors.blue.shade100 : Colors.white,
          borderColor: selectableInterest.selected ? colors.blue.shade600 : darkBlue.shade300,
          borderWidth: 1,
          blurRadius: null,
          borderRadius: _interestRadius,
        );
      }).toList(),
    );
  }
}

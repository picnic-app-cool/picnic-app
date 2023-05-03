import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicSingleChoiceSelector extends StatelessWidget {
  const PicnicSingleChoiceSelector({
    Key? key,
    required this.choices,
    required this.selectedChoice,
    this.itemsPerRow = defaultItemsCount,
    required this.onTapChoice,
  }) : super(key: key);

  static const defaultItemsCount = 2;

  final List<PicnicSingleChoice<BanType>> choices;
  final PicnicSingleChoice<BanType> selectedChoice;
  final Function(PicnicSingleChoice<BanType>) onTapChoice;
  final int itemsPerRow;

  static const _enabledBorderWidth = 3.0;
  static const _borderWidth = 0.5;

  static const _lowOpacity = .2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    const spacing = 8.0;
    final itemsPerRow = min(this.itemsPerRow, choices.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: choices.map(
            (choice) {
              final isSelected = selectedChoice.value == choice.value;
              final blackAndWhite = colors.blackAndWhite;
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth / itemsPerRow - (itemsPerRow * spacing),
                ),
                child: PicnicButton(
                  title: choice.label,
                  titleColor: Colors.black,
                  icon: choice.iconPath,
                  borderRadius: const PicnicButtonRadius.semiRound(),
                  originalIconColor: true,
                  color: isSelected ? colors.green.withOpacity(_lowOpacity) : blackAndWhite.shade100,
                  borderColor: isSelected ? colors.green : blackAndWhite.shade400,
                  style: PicnicButtonStyle.outlined,
                  borderWidth: isSelected ? _enabledBorderWidth : _borderWidth,
                  onTap: () => onTapChoice(choice),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class PicnicSingleChoice<T> extends Equatable {
  const PicnicSingleChoice({
    required this.label,
    required this.iconPath,
    required this.value,
  });

  final String label;
  final String iconPath;
  final T value;

  @override
  List<Object?> get props => [
        label,
        iconPath,
        value,
      ];
}

extension BanTypeSingleChoice on BanType {
  PicnicSingleChoice<BanType> toSingleChoice() {
    switch (this) {
      case BanType.permanent:
        return PicnicSingleChoice<BanType>(
          label: appLocalizations.permanentBanChoice,
          iconPath: Assets.images.banIcon.path,
          value: this,
        );

      case BanType.temporary:
        return PicnicSingleChoice<BanType>(
          label: appLocalizations.dayBanChoice,
          iconPath: Assets.images.hourglass.path,
          value: this,
        );
    }
  }
}

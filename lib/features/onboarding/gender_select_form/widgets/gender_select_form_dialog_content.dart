import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class GenderSelectFormDialogContent extends StatelessWidget {
  const GenderSelectFormDialogContent({
    Key? key,
    required this.theme,
    required this.state,
    required this.onTapSelectGender,
  }) : super(key: key);

  final PicnicThemeData theme;
  final GenderSelectFormViewModel state;
  final void Function(Gender) onTapSelectGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _GenderSelectButton(
          theme: theme,
          isSelected: Gender.female == state.selectedGender,
          gender: Gender.female,
          onTapSelectGender: onTapSelectGender,
        ),
        const Gap(8),
        _GenderSelectButton(
          theme: theme,
          isSelected: Gender.male == state.selectedGender,
          gender: Gender.male,
          onTapSelectGender: onTapSelectGender,
        ),
        const Gap(8),
        _GenderSelectButton(
          theme: theme,
          isSelected: Gender.nonBinary == state.selectedGender,
          gender: Gender.nonBinary,
          onTapSelectGender: onTapSelectGender,
        ),
        const Gap(8),
        _GenderSelectButton(
          theme: theme,
          isSelected: Gender.preferNotToSay == state.selectedGender,
          gender: Gender.preferNotToSay,
          onTapSelectGender: onTapSelectGender,
        ),
      ],
    );
  }
}

class _GenderSelectButton extends StatelessWidget {
  const _GenderSelectButton({
    Key? key,
    required this.theme,
    this.isSelected = false,
    required this.gender,
    required this.onTapSelectGender,
  }) : super(key: key);

  final PicnicThemeData theme;
  final bool isSelected;
  final Gender gender;
  final void Function(Gender) onTapSelectGender;

  static const _selectedBorderWidth = 3.0;
  static const _unselectedBorderWidth = 1.0;
  static const _lowOpacity = .2;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;

    return PicnicButton(
      borderRadius: const PicnicButtonRadius.semiRound(),
      color: isSelected ? colors.blue.withOpacity(_lowOpacity) : Colors.transparent,
      borderColor: isSelected ? colors.blue : colors.blackAndWhite.shade400,
      style: PicnicButtonStyle.outlined,
      titleStyle: theme.styles.body30,
      borderWidth: isSelected ? _selectedBorderWidth : _unselectedBorderWidth,
      onTap: () => onTapSelectGender(gender),
      title: gender.valueToDisplay,
    );
  }
}

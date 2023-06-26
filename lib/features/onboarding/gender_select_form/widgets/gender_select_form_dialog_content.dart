import 'package:flutter/material.dart';
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
  final void Function(String) onTapSelectGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.genders.length,
          itemBuilder: (BuildContext context, int index) {
            final gender = state.genders[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _GenderSelectButton(
                theme: theme,
                isSelected: gender == state.selectedGender,
                gender: gender,
                onTapSelectGender: onTapSelectGender,
              ),
            );
          },
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
  final String gender;
  final void Function(String) onTapSelectGender;

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
      title: gender,
    );
  }
}

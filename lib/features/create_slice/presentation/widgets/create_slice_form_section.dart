import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_form.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CreateSliceFormSection extends StatelessWidget {
  const CreateSliceFormSection({
    required this.onChangedName,
    required this.onChangedDescription,
    required this.onDiscoverableValueChanged,
    required this.onPrivateValueChanged,
    required this.form,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<bool> onDiscoverableValueChanged;
  final ValueChanged<bool> onPrivateValueChanged;
  final CreateSliceForm form;

  static const _maxLinesTextInput = 3;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final subTitleTextStyle = theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600);
    return Column(
      children: [
        PicnicTextInput(
          initialValue: form.name,
          hintText: appLocalizations.sliceName,
          onChanged: onChangedName,
        ),
        const Gap(12),
        PicnicTextInput(
          initialValue: form.description,
          maxLines: _maxLinesTextInput,
          hintText: appLocalizations.sliceDescription,
          onChanged: onChangedDescription,
        ),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    appLocalizations.slicePrivateHeadline,
                    style: styles.subtitle30,
                  ),
                  const Spacer(),
                  PicnicSwitch(
                    value: form.private,
                    onChanged: (value) => onPrivateValueChanged(value),
                    size: PicnicSwitchSize.regular,
                    color: colors.blue,
                  ),
                ],
              ),
              Text(
                appLocalizations.slicePrivateDescription,
                style: subTitleTextStyle,
              ),
            ],
          ),
        ),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    appLocalizations.sliceDiscoverableHeadline,
                    style: styles.subtitle30,
                  ),
                  const Spacer(),
                  PicnicSwitch(
                    value: form.discoverable,
                    onChanged: (value) => onDiscoverableValueChanged(value),
                    size: PicnicSwitchSize.regular,
                    color: colors.blue,
                  ),
                ],
              ),
              Text(
                appLocalizations.sliceDiscoverableDescription,
                style: subTitleTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';

class EditCircleFormSection extends StatelessWidget {
  const EditCircleFormSection({
    required this.onChangedCircleName,
    required this.onChangedCircleDescription,
    required this.name,
    required this.description,
    super.key,
  });

  final ValueChanged<String> onChangedCircleName;
  final ValueChanged<String> onChangedCircleDescription;
  final String name;
  final String description;

  static const _maxLinesTextInput = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PicnicTextInput(
          padding: 0,
          initialValue: name,
          hintText: appLocalizations.createCircleTextInputNameHint,
          onChanged: onChangedCircleName,
        ),
        const Gap(12),
        PicnicTextInput(
          padding: 0,
          initialValue: description,
          maxLines: _maxLinesTextInput,
          hintText: appLocalizations.createCircleTextInputDescriptionHint,
          onChanged: onChangedCircleDescription,
        ),
      ],
    );
  }
}

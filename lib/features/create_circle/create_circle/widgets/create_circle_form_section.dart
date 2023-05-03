import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CreateCircleFormSection extends StatelessWidget {
  const CreateCircleFormSection({
    required this.onTapPickGroup,
    required this.onTapPickLanguage,
    required this.onChangedName,
    required this.onChangedDescription,
    required this.form,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapPickGroup;
  final VoidCallback onTapPickLanguage;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDescription;
  final CreateCircleForm form;

  static const _maxLinesTextInput = 3;
  static const _borderRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final dropdownImage = Assets.images.arrowDown.image();
    final language = form.language;
    final group = form.group;
    return Column(
      children: [
        PicnicTextInput(
          initialValue: form.name,
          hintText: appLocalizations.createCircleTextInputNameHint,
          onChanged: onChangedName,
        ),
        const Gap(12),
        PicnicTextInput(
          initialValue: form.description,
          maxLines: _maxLinesTextInput,
          hintText: appLocalizations.createCircleTextInputDescriptionHint,
          onChanged: onChangedDescription,
        ),
        const Gap(12),
        PicnicTextInput(
          readOnly: true,
          prefix: group.name.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PicnicTag(
                    title: group.name,

                    /// The color of this tag is being generated randomly based on the index of the list of groups in the
                    /// list sheet. Since here it's just one selected circle therefore:
                    // TODO: This color needs to be tagged with the individual selected circle group
                    backgroundColor: Colors.red,
                    borderRadius: _borderRadius,
                    blurRadius: null,
                  ),
                )
              : null,
          onTap: onTapPickGroup,
          hintText: group.name.isEmpty ? appLocalizations.createCircleTextInputGroupHint : '',
          suffix: Padding(
            padding: const EdgeInsets.all(12),
            child: dropdownImage,
          ),
        ),
        const Gap(12),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            appLocalizations.createCircleTextInputLanguageLabel,
            style: PicnicTheme.of(context).styles.body20,
          ),
        ),
        PicnicTextInput(
          readOnly: true,
          onTap: onTapPickLanguage,
          hintText: language.title.isEmpty
              ? appLocalizations.createCircleTextInputLanguageHint
              : language.flag + language.title,
          suffix: Padding(
            padding: const EdgeInsets.all(12),
            child: dropdownImage,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class AddBlackListWordPage extends StatefulWidget with HasPresenter<AddBlackListWordPresenter> {
  const AddBlackListWordPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AddBlackListWordPresenter presenter;

  @override
  State<AddBlackListWordPage> createState() => _AddBlackListWordPageState();
}

class _AddBlackListWordPageState extends State<AddBlackListWordPage>
    with PresenterStateMixin<AddBlackListWordViewModel, AddBlackListWordPresenter, AddBlackListWordPage> {
  static const paddingSize = 20.0;
  static const borderButtonWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.blacklistedWordsButtonConfirmationTitle,
              style: theme.styles.title30,
              textAlign: TextAlign.left,
            ),
            const Gap(8),
            Text(
              appLocalizations.blacklistedWordsButtonConfirmationMessage,
              style: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600),
              textAlign: TextAlign.left,
            ),
            const Gap(4),
            PicnicTextInput(
              initialValue: state.newWord,
              onChanged: presenter.onWordsInputChanged,
              hintText: appLocalizations.blacklistedWordsInputHint,
              padding: 0,
            ),
            const Gap(10),
            PicnicButton(
              borderRadius: const PicnicButtonRadius.round(),
              minWidth: double.infinity,
              title: appLocalizations.blacklistedWordsConfirmationButtonTitle,
              color: colors.pink,
              borderColor: colors.pink,
              titleColor: Colors.white,
              style: PicnicButtonStyle.outlined,
              borderWidth: borderButtonWidth,
              onTap: presenter.onTapAddWords,
            ),
            const Gap(4),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: presenter.onTapClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

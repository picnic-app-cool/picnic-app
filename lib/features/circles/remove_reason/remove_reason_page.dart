// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class RemoveReasonPage extends StatefulWidget with HasPresenter<RemoveReasonPresenter> {
  const RemoveReasonPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final RemoveReasonPresenter presenter;

  @override
  State<RemoveReasonPage> createState() => _RemoveReasonPageState();
}

class _RemoveReasonPageState extends State<RemoveReasonPage>
    with PresenterStateMixin<RemoveReasonViewModel, RemoveReasonPresenter, RemoveReasonPage> {
  static const _maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.close.path,
        child: Text(
          appLocalizations.removeReasonTitle,
          style: PicnicTheme.of(context).styles.title20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            PicnicTextInput(
              maxLines: _maxLines,
              onChanged: presenter.onTextChanged,
              hintText: appLocalizations.removeReasonHint,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: stateObserver(
                  builder: (context, state) {
                    return PicnicButton(
                      title: appLocalizations.continueAction,
                      onTap: state.isButtonEnabled ? presenter.onTapContinue : null,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

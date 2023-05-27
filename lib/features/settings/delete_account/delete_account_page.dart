// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presenter.dart';
import 'package:picnic_app/features/settings/delete_account/widgets/delete_account_reason_input_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_report_reason_description_input.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class DeleteAccountPage extends StatefulWidget with HasPresenter<DeleteAccountPresenter> {
  const DeleteAccountPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DeleteAccountPresenter presenter;

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage>
    with PresenterStateMixin<DeleteAccountViewModel, DeleteAccountPresenter, DeleteAccountPage> {
  static const _buttonBorderWidth = 2.0;
  static const _buttonWidth = 124.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final pinkColor = colors.pink;
    final textStyle = theme.styles.body20;

    final appBar = PicnicAppBar(
      backgroundColor: theme.colors.blackAndWhite.shade100,
      iconPathLeft: Assets.images.backArrow.path,
      child: Text(
        appLocalizations.deleteAccountTitle,
        style: theme.styles.subtitle30,
      ),
    );

    const contentPadding = EdgeInsets.symmetric(horizontal: 24);

    //This padding has to be setup in order to align delete button with [PicnicTextInput]
    const deleteButtonPadding = EdgeInsets.only(right: 8);

    final deleteAccountChallenge = Text(
      appLocalizations.deleteAccountChallenge,
      style: textStyle,
    );

    final leavingReasonMessage = Text(
      appLocalizations.leavingReasonMessage,
      style: textStyle,
    );

    final descriptionInput = PicnicReportReasonDescriptionInput(
      onChangedDescription: presenter.onChangedDescription,
    );

    return stateObserver(
      builder: (context, state) {
        final reasonTitle = state.deleteAccountReasonInput.deleteAccountReason.title;
        final deleteButton = PicnicButton(
          minWidth: _buttonWidth,
          title: appLocalizations.deleteAccountAction,
          color: pinkColor,
          borderColor: pinkColor,
          titleColor: Colors.white,
          style: PicnicButtonStyle.outlined,
          borderWidth: _buttonBorderWidth,
          onTap: state.deleteAccountEnabled ? presenter.onTabDeleteAccount : null,
        );

        final reasonInput = DeleteAccountReasonInputWidget(
          onTapDisplayReasons: presenter.onTapDisplayReasons,
          hintText: reasonTitle.isEmpty ? appLocalizations.selectReasonHint : "",
          reasonTitle: reasonTitle,
          onChangedReason: presenter.onChangedReason,
        );

        final enterCodeInput = PicnicTextInput(
          onChanged: presenter.onChangedDeleteChallenge,
          hintText: appLocalizations.delete,
        );

        //TODO : create a password challenge or implement sms verification : https://picnic-app.atlassian.net/browse/PG-1784
        return DarkStatusBar(
          child: Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Padding(
                padding: contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    deleteAccountChallenge,
                    enterCodeInput,
                    reasonInput,
                    leavingReasonMessage,
                    descriptionInput,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(padding: deleteButtonPadding, child: deleteButton),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

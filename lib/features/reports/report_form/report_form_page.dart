// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presentation_model.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presenter.dart';
import 'package:picnic_app/features/reports/report_form/widgets/send_reason_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_report_reason_description_input.dart';
import 'package:picnic_app/ui/widgets/picnic_report_reason_input.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ReportFormPage extends StatefulWidget with HasPresenter<ReportFormPresenter> {
  const ReportFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ReportFormPresenter presenter;

  @override
  State<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage>
    with PresenterStateMixin<ReportFormViewModel, ReportFormPresenter, ReportFormPage> {
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PicnicAppBar(
        titleText: appLocalizations.reportFormAppBarTitle,
      ),
      body: stateObserver(
        builder: (context, state) {
          final reasonTitle = state.reasonSelected.reason;
          return Stack(
            children: [
              if (state.isLoading)
                const Center(child: PicnicLoadingIndicator())
              else
                Padding(
                  padding: _padding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PicnicReportReasonInput(
                          onTapDisplayReasons: presenter.onTapDisplayReasons,
                          reasonTitle: reasonTitle,
                          hintText: reasonTitle.isEmpty ? appLocalizations.selectReasonHint : "",
                        ),
                        if (state.isShowDescription)
                          PicnicReportReasonDescriptionInput(
                            onChangedDescription: presenter.onChangedDescription,
                          ),
                        const Gap(8),
                        SendReasonButton(
                          onTapSendReport: state.reportEnabled ? presenter.onTapSendReport : null,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

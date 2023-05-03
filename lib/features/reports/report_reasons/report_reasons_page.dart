// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presentation_model.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presenter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ReportReasonsPage extends StatefulWidget with HasPresenter<ReportReasonsPresenter> {
  const ReportReasonsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ReportReasonsPresenter presenter;

  @override
  State<ReportReasonsPage> createState() => _ReportReasonsPageState();
}

class _ReportReasonsPageState extends State<ReportReasonsPage>
    with PresenterStateMixin<ReportReasonsViewModel, ReportReasonsPresenter, ReportReasonsPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.reasons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => presenter.onTapSelectReason(state.reasons[index]),
              title: Text(
                state.reasons[index].reason,
                style: PicnicTheme.of(context).styles.body20,
              ),
            );
          },
        ),
      ),
    );
  }
}

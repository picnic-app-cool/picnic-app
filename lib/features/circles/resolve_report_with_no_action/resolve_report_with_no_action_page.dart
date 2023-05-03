import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ResolveReportWithNoActionPage extends StatefulWidget with HasPresenter<ResolveReportWithNoActionPresenter> {
  const ResolveReportWithNoActionPage({
    super.key,
    required this.presenter,
  });

  @override
  final ResolveReportWithNoActionPresenter presenter;

  @override
  State<ResolveReportWithNoActionPage> createState() => _ResolveReportWithNoActionPageState();
}

class _ResolveReportWithNoActionPageState extends State<ResolveReportWithNoActionPage>
    with
        PresenterStateMixin<ResolveReportWithNoActionViewModel, ResolveReportWithNoActionPresenter,
            ResolveReportWithNoActionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: stateObserver(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20.0),
              Text(
                appLocalizations.resolveWithNoActionTitle,
                style: theme.styles.title30,
              ),
              const Gap(8.0),
              Text(
                appLocalizations.resolveWithNoActionDescription,
                style: theme.styles.caption20.copyWith(
                  color: colors.blackAndWhite.shade600,
                ),
              ),
              const Gap(20.0),
              SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  title: appLocalizations.resolveWithNoActionConfirmation,
                  color: colors.red,
                  onTap: presenter.onTapResolveWithNoAction,
                ),
              ),
              const Gap(8.0),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.resolveWithNoActionCancel,
                  onTap: presenter.onTapClose,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

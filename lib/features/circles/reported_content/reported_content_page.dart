// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presenter.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ReportedContentPage extends StatefulWidget with HasPresenter<ReportedContentPresenter> {
  const ReportedContentPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ReportedContentPresenter presenter;

  @override
  State<ReportedContentPage> createState() => _ReportedContentPageState();
}

class _ReportedContentPageState extends State<ReportedContentPage>
    with PresenterStateMixin<ReportedContentViewModel, ReportedContentPresenter, ReportedContentPage> {
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final redColor = colors.red;
    final purpleColor = colors.purple;
    final title = state.reportType == ReportEntityType.post
        ? appLocalizations.reportedPostTitle
        : appLocalizations.reportedCommentTitle;
    final buttonText = state.reportType == ReportEntityType.post
        ? appLocalizations.removePostAction
        : appLocalizations.removeCommentAction;
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
                title,
                style: theme.styles.title30,
              ),
              const Gap(20.0),
              SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  title: buttonText,
                  color: redColor,
                  onTap: presenter.onTapRemove,
                ),
              ),
              const Gap(16.0),
              SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  title: appLocalizations.banUserLabel,
                  style: PicnicButtonStyle.outlined,
                  borderColor: redColor,
                  titleColor: redColor,
                  borderWidth: _borderWidth,
                  onTap: presenter.onTapBan,
                ),
              ),
              const Gap(16.0),
              SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  title: appLocalizations.resolveWithNoActionLabel,
                  style: PicnicButtonStyle.outlined,
                  borderColor: purpleColor,
                  titleColor: purpleColor,
                  borderWidth: _borderWidth,
                  onTap: presenter.onTapResolveWithNoAction,
                ),
              ),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.closeAction,
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

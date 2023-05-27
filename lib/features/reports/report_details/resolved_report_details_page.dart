import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/widgets/mod_sheet_title.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presentation_model.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ResolvedReportDetailsPage extends StatefulWidget with HasPresenter<ResolvedReportDetailsPresenter> {
  const ResolvedReportDetailsPage({required this.presenter, Key? key}) : super(key: key);

  @override
  final ResolvedReportDetailsPresenter presenter;

  @override
  State<StatefulWidget> createState() {
    return _ResolvedReportDetailsPage();
  }
}

class _ResolvedReportDetailsPage extends State<ResolvedReportDetailsPage>
    with
        PresenterStateMixin<ResolvedReportDetailsViewModel, ResolvedReportDetailsPresenter, ResolvedReportDetailsPage> {
  static const _radius = 16.0;
  static const _avatarSize = 45.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ModSheetTitle(title: appLocalizations.reportDetailsTitle),
          stateObserver(
            builder: (context, state) => PicnicListItem(
              title: state.reportedUserProfile.username,
              titleStyle: theme.styles.subtitle20,
              subTitle: appLocalizations.responsibleModLabel,
              subTitleStyle: theme.styles.caption10.copyWith(color: theme.colors.blackAndWhite.shade900),
              leading: PicnicAvatar(
                size: _avatarSize,
                boxFit: PicnicAvatarChildBoxFit.cover,
                isCrowned: state.reportedUserProfile.isVerified,
                imageSource: PicnicImageSource.url(
                  ImageUrl(state.reportedUserProfile.profileImageUrl.url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          stateObserver(
            builder: (context, state) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.blackAndWhite.shade200,
                borderRadius: BorderRadius.circular(_radius),
              ),
              child: Text(
                appLocalizations.resolvedReportDateLabel + state.reportedAtFormatted,
                style: theme.styles.body20.copyWith(
                  color: colors.blackAndWhite.shade900,
                ),
              ),
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
    );
  }
}

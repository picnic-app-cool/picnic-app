import 'package:flutter/material.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/report_avatar.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

class MessageReportView extends StatelessWidget {
  const MessageReportView({
    required this.circleName,
    required this.circleEmoji,
    required this.circleImage,
    required this.reportedPost,
    required this.onTap,
  });

  final String circleName;
  final String circleEmoji;
  final String circleImage;
  final Function(ViolationReport) onTap;
  final MessageReport reportedPost;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final titleStyle = theme.styles.body0.copyWith(
      color: colors.blackAndWhite.shade600,
    );
    final isResolved = reportedPost.status == ResolveStatus.resolved;
    final arrowIcon = Image.asset(Assets.images.arrowDown.path);
    final infoIcon = Image.asset(Assets.images.infoOutlined.path);
    return PicnicListItem(
      height: null,
      onTap: () => onTap(reportedPost),
      title: reportedPost.spammer.username.formattedUsername,
      titleStyle: titleStyle,
      subTitleStyle: _getFontStyle(
        theme: theme,
        color: theme.colors.blackAndWhite.shade900,
        isResolved: isResolved,
      ),
      subTitle: appLocalizations.reportedLabelFormat(reportedPost.reporter.username.formattedUsername),
      subTitleSpan: appLocalizations.reportedMessage,
      subTitleSpanStyle: _getFontStyle(
        theme: theme,
        color: colors.blue.shade600,
        isResolved: isResolved,
      ),
      trailing: isResolved ? infoIcon : arrowIcon,
      leading: ReportAvatar(
        circleEmoji: circleEmoji,
        circleImage: reportedPost.spammer.profileImageUrl.url,
        isResolved: reportedPost.status == ResolveStatus.resolved,
      ),
    );
  }

  TextStyle _getFontStyle({
    required PicnicThemeData theme,
    required Color color,
    required bool isResolved,
  }) =>
      isResolved
          ? theme.styles.caption10.copyWith(
              color: color,
            )
          : theme.styles.body20.copyWith(
              color: color,
            );
}

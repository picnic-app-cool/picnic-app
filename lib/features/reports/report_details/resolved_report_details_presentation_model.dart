import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/utils/extensions/date_formatting.dart';

class ResolvedReportDetailsPresentationModel implements ResolvedReportDetailsViewModel {
  ResolvedReportDetailsPresentationModel.initial(ResolvedReportDetailsInitialParams initialParams)
      : resolvedAt = initialParams.resolvedAt,
        reportedUserProfile = initialParams.moderator;

  ResolvedReportDetailsPresentationModel._({
    required this.resolvedAt,
    required this.reportedUserProfile,
  });

  final String resolvedAt;

  @override
  final BasicPublicProfile reportedUserProfile;

  @override
  String get reportedAtFormatted =>
      " ${DateTime.tryParse(resolvedAt)?.monthName} ${DateTime.tryParse(resolvedAt)?.day}";

  ResolvedReportDetailsPresentationModel copyWith({
    BasicPublicProfile? reportedUserProfile,
    String? resolvedAt,
  }) =>
      ResolvedReportDetailsPresentationModel._(
        resolvedAt: resolvedAt ?? this.resolvedAt,
        reportedUserProfile: reportedUserProfile ?? this.reportedUserProfile,
      );
}

abstract class ResolvedReportDetailsViewModel {
  BasicPublicProfile get reportedUserProfile;

  String get reportedAtFormatted;
}

import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ReportedContentPresentationModel implements ReportedContentViewModel {
  /// Creates the initial state
  ReportedContentPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ReportedContentInitialParams initialParams,
  )   : postAuthor = initialParams.author,
        circleId = initialParams.circleId,
        reportId = initialParams.reportId,
        reportType = initialParams.reportType;

  /// Used for the copyWith method
  ReportedContentPresentationModel._({
    required this.postAuthor,
    required this.circleId,
    required this.reportId,
    required this.reportType,
  });

  @override
  final MinimalPublicProfile postAuthor;

  @override
  final Id circleId;

  @override
  final Id reportId;

  @override
  final ReportEntityType reportType;

  ReportedContentPresentationModel copyWith({
    MinimalPublicProfile? postAuthor,
    Id? circleId,
    Id? reportId,
    ReportEntityType? reportType,
  }) {
    return ReportedContentPresentationModel._(
      postAuthor: postAuthor ?? this.postAuthor,
      circleId: circleId ?? this.circleId,
      reportId: reportId ?? this.reportId,
      reportType: reportType ?? this.reportType,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ReportedContentViewModel {
  MinimalPublicProfile get postAuthor;

  Id get circleId;

  Id get reportId;

  ReportEntityType get reportType;
}

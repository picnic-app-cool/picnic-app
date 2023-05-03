import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

class UnknownReport extends Equatable implements ViolationReport {
  const UnknownReport({
    this.status = ResolveStatus.unknown,
  });

  const UnknownReport.empty() : status = ResolveStatus.unknown;

  @override
  final ResolveStatus status;

  @override
  ReportEntityType get reportType => ReportEntityType.unknown;

  @override
  BasicPublicProfile get moderator => const BasicPublicProfile.empty();

  @override
  BasicPublicProfile get reporter => const BasicPublicProfile.empty();

  @override
  String get resolvedAt => '';

  @override
  BasicPublicProfile get spammer => const BasicPublicProfile.empty();

  @override
  List<Object?> get props => [
        reportType,
        status,
      ];

  UnknownReport copyWith({
    ResolveStatus? status,
  }) {
    return const UnknownReport();
  }
}

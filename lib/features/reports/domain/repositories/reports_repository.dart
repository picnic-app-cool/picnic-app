import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/reports/domain/model/create_circle_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/create_global_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/model/get_report_reasons_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/report_input.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';

abstract class ReportsRepository {
  /// Get list of reasons for given report type
  Future<Either<GetReportReasonsFailure, List<ReportReason>>> getGlobalReportReasons({
    required ReportEntityType reportEntityType,
  });

  /// Send global report input based
  Future<Either<CreateGlobalReportFailure, Unit>> createGlobalReport({
    required CreateReportInput report,
  });

  /// Send circle report input based
  Future<Either<CreateCircleReportFailure, Unit>> createCircleReport({
    required ReportInput report,
  });
}

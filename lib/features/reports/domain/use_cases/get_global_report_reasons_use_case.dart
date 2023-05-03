import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/reports/domain/model/get_report_reasons_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/domain/repositories/reports_repository.dart';

class GetGlobalReportReasonsUseCase {
  const GetGlobalReportReasonsUseCase(this._reportsRepository);

  final ReportsRepository _reportsRepository;

  Future<Either<GetReportReasonsFailure, List<ReportReason>>> execute({
    required ReportEntityType reportEntityType,
  }) async {
    return _reportsRepository.getGlobalReportReasons(
      reportEntityType: reportEntityType,
    );
  }
}

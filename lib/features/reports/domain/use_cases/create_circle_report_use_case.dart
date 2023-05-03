import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/reports/domain/model/create_circle_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_input.dart';
import 'package:picnic_app/features/reports/domain/repositories/reports_repository.dart';

class CreateCircleReportUseCase {
  const CreateCircleReportUseCase(this._reportsRepository);

  final ReportsRepository _reportsRepository;

  Future<Either<CreateCircleReportFailure, Unit>> execute({
    required ReportInput report,
  }) async =>
      _reportsRepository.createCircleReport(
        report: report,
      );
}

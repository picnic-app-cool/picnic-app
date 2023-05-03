import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/reports/domain/model/create_global_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/repositories/reports_repository.dart';

class CreateGlobalReportUseCase {
  const CreateGlobalReportUseCase(this._reportsRepository);

  final ReportsRepository _reportsRepository;

  Future<Either<CreateGlobalReportFailure, Unit>> execute({
    required CreateReportInput report,
  }) async {
    return _reportsRepository.createGlobalReport(
      report: report,
    );
  }
}

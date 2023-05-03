import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/resolve_report_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_reports_repository.dart';

class ResolveReportUseCase {
  const ResolveReportUseCase(this._circleReportsRepository);

  final CircleReportsRepository _circleReportsRepository;

  Future<Either<ResolveReportFailure, Unit>> execute({
    required Id circleId,
    required Id reportId,
    required bool fullFill,
  }) =>
      _circleReportsRepository.resolveReport(
        circleId: circleId,
        reportId: reportId,
        resolve: fullFill,
      );
}

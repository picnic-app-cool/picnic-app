import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/circle_report_reason.dart';
import 'package:picnic_app/features/reports/domain/model/get_report_reasons_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';

class GetCircleReportReasonsUseCase {
  Future<Either<GetReportReasonsFailure, List<ReportReason>>> execute() async {
    return success(
      CircleReportReason.allCircleReasons
          .map(
            (circleReason) => ReportReason(id: const Id.empty(), reason: circleReason.valueToDisplay),
          )
          .toList(),
    );
  }
}

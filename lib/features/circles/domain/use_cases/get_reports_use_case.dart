import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_reports_failure.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_reports_repository.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';

class GetReportsUseCase {
  const GetReportsUseCase(this._circleReportsRepository);

  final CircleReportsRepository _circleReportsRepository;

  Future<Either<GetReportsFailure, PaginatedList<ViolationReport>>> execute({
    required Id circleId,
    required Cursor nextPageCursor,
    required CircleReportsFilterBy filterBy,
  }) =>
      _circleReportsRepository.getReports(
        circleId: circleId,
        nextPageCursor: nextPageCursor,
        filterBy: filterBy,
      );
}

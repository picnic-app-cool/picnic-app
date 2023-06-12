import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_circles_failure.dart';

class GetLastUsedCirclesUseCase {
  const GetLastUsedCirclesUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetLastUsedCirclesFailure, PaginatedList<Circle>>> execute({
    required Cursor cursor,
  }) async =>
      _circlesRepository.getLastUsedCircles(nextPageCursor: cursor);
}

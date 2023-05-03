import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';

class GetCirclesUseCase {
  const GetCirclesUseCase(
    this._circlesRepository,
  );

  final CirclesRepository _circlesRepository;

  Future<Either<GetCirclesFailure, PaginatedList<Circle>>> execute({
    String? query,
    Cursor? nextPageCursor,
  }) =>
      _circlesRepository.getCircles(
        searchQuery: query,
        nextPageCursor: nextPageCursor,
      );
}

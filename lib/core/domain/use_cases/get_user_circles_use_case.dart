import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetUserCirclesUseCase {
  const GetUserCirclesUseCase(
    this._circlesRepository,
  );

  final CirclesRepository _circlesRepository;

  Future<Either<GetUserCirclesFailure, PaginatedList<Circle>>> execute({
    Id? userId,
    String? searchQuery,
    List<CircleRole>? roles,
    required Cursor nextPageCursor,
  }) =>
      _circlesRepository.getUserCircles(
        userId: userId,
        searchQuery: searchQuery,
        nextPageCursor: nextPageCursor,
        roles: roles,
      );
}

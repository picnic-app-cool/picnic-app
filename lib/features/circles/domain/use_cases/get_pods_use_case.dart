import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_pods_failure.dart';

class GetPodsUseCase {
  const GetPodsUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetPodsFailure, PaginatedList<CirclePodApp>>> execute({
    required Id circleId,
    required Cursor cursor,
  }) =>
      _circlesRepository.getPods(circleId: circleId, cursor: cursor);
}

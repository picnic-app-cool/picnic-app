import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_trending_pods_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';

class GetTrendingPodsUseCase {
  const GetTrendingPodsUseCase(
    this._podsRepository,
  );

  final PodsRepository _podsRepository;

  Future<Either<GetTrendingPodsFailure, PaginatedList<PodApp>>> execute({
    Cursor? cursor,
  }) async {
    return _podsRepository.getTrendingPods(cursor: cursor);
  }
}

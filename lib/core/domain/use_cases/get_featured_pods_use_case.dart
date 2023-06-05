import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/featured_pods_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';

class GetFeaturedPodsUseCase {
  const GetFeaturedPodsUseCase(
    this._podsRepository,
  );

  final PodsRepository _podsRepository;

  Future<Either<FeaturedPodsFailure, PaginatedList<PodApp>>> execute({required Cursor nextPageCursor}) async {
    return _podsRepository.getFeaturedPods(nextPageCursor: nextPageCursor);
  }
}

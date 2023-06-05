import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/pods/domain/model/get_saved_pods_failure.dart';

class GetSavedPodsUseCase {
  const GetSavedPodsUseCase(this._podsRepository);

  final PodsRepository _podsRepository;

  Future<Either<GetSavedPodsFailure, PaginatedList<PodApp>>> execute({required Cursor nextPageCursor}) async =>
      _podsRepository.getSavedPods(nextPageCursor: nextPageCursor);
}

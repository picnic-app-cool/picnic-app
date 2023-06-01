import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/model/search_pods_failure.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';

class SearchPodsUseCase {
  const SearchPodsUseCase(
    this._podsRepository,
  );

  final PodsRepository _podsRepository;

  Future<Either<SearchPodsFailure, PaginatedList<PodApp>>> execute({
    required SearchPodInput input,
  }) async {
    return _podsRepository.searchPods(input: input);
  }
}

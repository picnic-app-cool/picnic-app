import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_failure.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_input.dart';

class GetRecommendedCirclesUseCase {
  const GetRecommendedCirclesUseCase(
    this._podsRepository,
  );

  final PodsRepository _podsRepository;

  Future<Either<GetRecommendedCirclesFailure, PaginatedList<Circle>>> execute(GetRecommendedCirclesInput input) async =>
      _podsRepository.getRecommendedCircles(input);
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/post_creation_circles_repository.dart';

class GetPostCreationCirclesUseCase {
  const GetPostCreationCirclesUseCase(this._postCreationCirclesRepository);

  final PostCreationCirclesRepository _postCreationCirclesRepository;

  Future<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> execute({
    required String searchQuery,
  }) async =>
      _postCreationCirclesRepository.getPostCreationCircles(searchQuery: searchQuery);
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

abstract class PostCreationCirclesRepository {
  Future<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> getPostCreationCircles({
    required String searchQuery,
  });
}

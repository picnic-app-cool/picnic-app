import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/repositories/post_creation_circles_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GraphqlPostCreationCirclesRepository implements PostCreationCirclesRepository {
  GraphqlPostCreationCirclesRepository(this._circlesRepository);

  @visibleForTesting
  PaginatedList<Circle> userCircles = const PaginatedList.empty();

  @visibleForTesting
  PaginatedList<Circle> otherCircles = const PaginatedList.empty();

  final CirclesRepository _circlesRepository;

  String _searchQuery = '';

  @override
  Future<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> getPostCreationCircles({
    required String searchQuery,
  }) async {
    if (_searchQuery != searchQuery) {
      _searchQuery = searchQuery;
      userCircles = const PaginatedList.empty();
      otherCircles = const PaginatedList.empty();
    }
    return userCircles.hasNextPage
        ? _getUserCircles(searchQuery: searchQuery)
        : _getOtherCircles(searchQuery: searchQuery);
  }

  Future<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> _getUserCircles({
    required String searchQuery,
  }) =>
      _circlesRepository
          .getUserCircles(
            searchQuery: searchQuery,
            nextPageCursor: userCircles.nextPageCursor(),
          )
          .mapFailure((_) => const GetPostCreationCirclesFailure.unknown())
          .doOn(
            success: (success) => userCircles = userCircles.byAppending(success),
          )
          .mapSuccess(
            (response) => response.copyWith(
              pageInfo: response.hasNextPage ? response.pageInfo : otherCircles.pageInfo,
              items: response.items,
            ),
          );

  Future<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> _getOtherCircles({
    required String searchQuery,
  }) =>
      _circlesRepository
          .getCircles(
            searchQuery: searchQuery,
            nextPageCursor: otherCircles.nextPageCursor(),
          )
          .mapFailure((_) => const GetPostCreationCirclesFailure.unknown())
          .doOn(
            success: (success) => otherCircles = otherCircles.byAppending(_circlesExcludingUserCircles(success)),
          )
          .mapSuccess(_circlesExcludingUserCircles);

  PaginatedList<Circle> _circlesExcludingUserCircles(PaginatedList<Circle> circles) => circles.copyWith(
        items: circles.items.where((circle) {
          return !userCircles.items.contains(circle);
        }).toList(),
      );
}

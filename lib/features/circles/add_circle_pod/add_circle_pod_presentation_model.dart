import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AddCirclePodPresentationModel implements AddCirclePodViewModel {
  /// Creates the initial state
  AddCirclePodPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AddCirclePodInitialParams initialParams,
  )   : getCirclesFutureResult = const FutureResult.empty(),
        circles = const PaginatedList.empty(),
        podId = initialParams.podId,
        searchQuery = '';

  /// Used for the copyWith method
  AddCirclePodPresentationModel._({
    required this.getCirclesFutureResult,
    required this.circles,
    required this.searchQuery,
    required this.podId,
  });

  final FutureResult<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> getCirclesFutureResult;

  @override
  final PaginatedList<Circle> circles;
  final String searchQuery;
  final Id podId;

  Cursor get nextPageCursor => circles.nextPageCursor();

  bool get isLoading => getCirclesFutureResult.isPending();

  @override
  bool get isEmpty => !isLoading && !circles.pageInfo.hasNextPage && circles.items.isEmpty;

  AddCirclePodPresentationModel byAppendingCircles(
    PaginatedList<Circle> list,
  ) =>
      copyWith(circles: circles + list);

  AddCirclePodPresentationModel copyWith({
    FutureResult<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>>? getCirclesFutureResult,
    PaginatedList<Circle>? circles,
    String? searchQuery,
    Id? podId,
  }) {
    return AddCirclePodPresentationModel._(
      getCirclesFutureResult: getCirclesFutureResult ?? this.getCirclesFutureResult,
      circles: circles ?? this.circles,
      searchQuery: searchQuery ?? this.searchQuery,
      podId: podId ?? this.podId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AddCirclePodViewModel {
  PaginatedList<Circle> get circles;

  bool get isEmpty;
}

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SelectCirclePresentationModel implements SelectCircleViewModel {
  /// Creates the initial state
  SelectCirclePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SelectCircleInitialParams initialParams,
  )   : getCirclesFutureResult = const FutureResult.empty(),
        circles = const PaginatedList.empty(),
        createPostInput = initialParams.createPostInput,
        searchQuery = '';

  /// Used for the copyWith method
  SelectCirclePresentationModel._({
    required this.getCirclesFutureResult,
    required this.circles,
    required this.searchQuery,
    required this.createPostInput,
  });

  final FutureResult<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>> getCirclesFutureResult;

  @override
  final PaginatedList<Circle> circles;
  final String searchQuery;
  final CreatePostInput createPostInput;

  Cursor get nextPageCursor => circles.nextPageCursor();

  bool get isLoading => getCirclesFutureResult.isPending();

  @override
  bool get isEmpty => !isLoading && !circles.pageInfo.hasNextPage && circles.items.isEmpty;

  @override
  PostType get postType => createPostInput.type;

  SelectCirclePresentationModel byAppendingCircles(
    PaginatedList<Circle> list,
  ) =>
      copyWith(circles: circles + list);

  SelectCirclePresentationModel copyWith({
    FutureResult<Either<GetPostCreationCirclesFailure, PaginatedList<Circle>>>? getCirclesFutureResult,
    PaginatedList<Circle>? circles,
    String? searchQuery,
    CreatePostInput? createPostInput,
  }) {
    return SelectCirclePresentationModel._(
      getCirclesFutureResult: getCirclesFutureResult ?? this.getCirclesFutureResult,
      circles: circles ?? this.circles,
      searchQuery: searchQuery ?? this.searchQuery,
      createPostInput: createPostInput ?? this.createPostInput,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SelectCircleViewModel {
  PaginatedList<Circle> get circles;

  bool get isEmpty;

  PostType get postType;
}

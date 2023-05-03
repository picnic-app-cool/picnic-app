import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CirclesSideMenuPresentationModel implements CirclesSideMenuViewModel {
  /// Creates the initial state
  CirclesSideMenuPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CirclesSideMenuInitialParams initialParams,
  )   : userCirclesResult = const FutureResult.empty(),
        onCircleSideMenuAction = initialParams.onCircleSideMenuAction,
        userCircles = const PaginatedList.empty();

  /// Used for the copyWith method
  CirclesSideMenuPresentationModel._({
    required this.userCirclesResult,
    required this.onCircleSideMenuAction,
    required this.userCircles,
  });

  final FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>> userCirclesResult;
  final VoidCallback onCircleSideMenuAction;

  @override
  final PaginatedList<Circle> userCircles;

  @override
  bool get isCirclesLoading => userCirclesResult.isPending();

  Cursor get userCirclesCursor => userCircles.nextPageCursor();

  CirclesSideMenuPresentationModel copyWith({
    FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>>? userCirclesResult,
    PaginatedList<Circle>? userCircles,
    VoidCallback? onCircleSideMenuAction,
  }) {
    return CirclesSideMenuPresentationModel._(
      userCirclesResult: userCirclesResult ?? this.userCirclesResult,
      userCircles: userCircles ?? this.userCircles,
      onCircleSideMenuAction: onCircleSideMenuAction ?? this.onCircleSideMenuAction,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CirclesSideMenuViewModel {
  bool get isCirclesLoading;

  PaginatedList<Circle> get userCircles;
}

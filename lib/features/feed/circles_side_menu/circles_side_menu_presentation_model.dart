import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/pods/domain/model/get_saved_pods_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CirclesSideMenuPresentationModel implements CirclesSideMenuViewModel {
  /// Creates the initial state
  CirclesSideMenuPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CirclesSideMenuInitialParams initialParams,
    UserStore userStore,
  )   : userCirclesResult = const FutureResult.empty(),
        onCircleSideMenuAction = initialParams.onCircleSideMenuAction,
        collections = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        collectionsResult = const FutureResult.empty(),
        savedPods = const PaginatedList.empty(),
        savedPodsResult = const FutureResult.empty(),
        userCircles = const PaginatedList.empty();

  /// Used for the copyWith method
  CirclesSideMenuPresentationModel._({
    required this.userCirclesResult,
    required this.onCircleSideMenuAction,
    required this.userCircles,
    required this.collectionsResult,
    required this.collections,
    required this.privateProfile,
    required this.savedPods,
    required this.savedPodsResult,
  });

  final FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>> userCirclesResult;
  final FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>> collectionsResult;
  final FutureResult<Either<GetSavedPodsFailure, PaginatedList<PodApp>>> savedPodsResult;

  @override
  final PaginatedList<Collection> collections;

  @override
  final PaginatedList<PodApp> savedPods;

  @override
  final PrivateProfile privateProfile;

  final VoidCallback onCircleSideMenuAction;

  @override
  final PaginatedList<Circle> userCircles;

  @override
  bool get isCirclesLoading => userCirclesResult.isPending();

  @override
  bool get isLoadingPods => savedPodsResult.isPending();

  @override
  bool get isLoadingCollections => collectionsResult.isPending();

  Cursor get userCirclesCursor => userCircles.nextPageCursor();

  Cursor get collectionCursor => collections.nextPageCursor();

  CirclesSideMenuPresentationModel copyWith({
    FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>>? userCirclesResult,
    PaginatedList<Circle>? userCircles,
    VoidCallback? onCircleSideMenuAction,
    FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>>? collectionsResult,
    PaginatedList<Collection>? collections,
    PrivateProfile? privateProfile,
    FutureResult<Either<GetSavedPodsFailure, PaginatedList<PodApp>>>? savedPodsResult,
    PaginatedList<PodApp>? savedPods,
  }) {
    return CirclesSideMenuPresentationModel._(
      userCirclesResult: userCirclesResult ?? this.userCirclesResult,
      userCircles: userCircles ?? this.userCircles,
      collectionsResult: collectionsResult ?? this.collectionsResult,
      privateProfile: privateProfile ?? this.privateProfile,
      collections: collections ?? this.collections,
      onCircleSideMenuAction: onCircleSideMenuAction ?? this.onCircleSideMenuAction,
      savedPodsResult: savedPodsResult ?? this.savedPodsResult,
      savedPods: savedPods ?? this.savedPods,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CirclesSideMenuViewModel {
  bool get isCirclesLoading;

  PaginatedList<Circle> get userCircles;

  bool get isLoadingCollections;

  PaginatedList<Collection> get collections;

  PrivateProfile get privateProfile;

  PaginatedList<PodApp> get savedPods;

  bool get isLoadingPods;
}

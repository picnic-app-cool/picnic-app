import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_circles_failure.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/pods/domain/model/get_saved_pods_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CirclesSideMenuPresentationModel implements CirclesSideMenuViewModel {
  /// Creates the initial state
  CirclesSideMenuPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CirclesSideMenuInitialParams initialParams,
    UserStore userStore,
  )   : lastUsedCirclesResult = const FutureResult.empty(),
        onCircleSideMenuAction = initialParams.onCircleSideMenuAction,
        collections = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        collectionsResult = const FutureResult.empty(),
        savedPods = const PaginatedList.empty(),
        savedPodsResult = const FutureResult.empty(),
        lastUsedCircles = const PaginatedList.empty(),
        followersCount = 0,
        followingCount = 0;

  /// Used for the copyWith method
  CirclesSideMenuPresentationModel._({
    required this.lastUsedCirclesResult,
    required this.onCircleSideMenuAction,
    required this.lastUsedCircles,
    required this.collectionsResult,
    required this.collections,
    required this.privateProfile,
    required this.savedPods,
    required this.savedPodsResult,
    required this.followersCount,
    required this.followingCount,
  });

  final FutureResult<Either<GetLastUsedCirclesFailure, PaginatedList<Circle>>> lastUsedCirclesResult;
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
  final PaginatedList<Circle> lastUsedCircles;

  @override
  final int followersCount;

  @override
  final int followingCount;

  @override
  bool get isCirclesLoading => lastUsedCirclesResult.isPending();

  @override
  bool get isLoadingPods => savedPodsResult.isPending();

  @override
  bool get isLoadingCollections => collectionsResult.isPending();

  Cursor get lastUsedCirclesCursor => lastUsedCircles.nextPageCursor();

  Cursor get collectionCursor => collections.nextPageCursor();

  @override
  bool get isAndroid => Platform.isAndroid;

  CirclesSideMenuPresentationModel copyWith({
    FutureResult<Either<GetLastUsedCirclesFailure, PaginatedList<Circle>>>? lastUsedCirclesResult,
    PaginatedList<Circle>? lastUsedCircles,
    VoidCallback? onCircleSideMenuAction,
    FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>>? collectionsResult,
    PaginatedList<Collection>? collections,
    PrivateProfile? privateProfile,
    FutureResult<Either<GetSavedPodsFailure, PaginatedList<PodApp>>>? savedPodsResult,
    PaginatedList<PodApp>? savedPods,
    int? followersCount,
    int? followingCount,
  }) {
    return CirclesSideMenuPresentationModel._(
      lastUsedCirclesResult: lastUsedCirclesResult ?? this.lastUsedCirclesResult,
      lastUsedCircles: lastUsedCircles ?? this.lastUsedCircles,
      collectionsResult: collectionsResult ?? this.collectionsResult,
      privateProfile: privateProfile ?? this.privateProfile,
      collections: collections ?? this.collections,
      onCircleSideMenuAction: onCircleSideMenuAction ?? this.onCircleSideMenuAction,
      savedPodsResult: savedPodsResult ?? this.savedPodsResult,
      savedPods: savedPods ?? this.savedPods,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CirclesSideMenuViewModel {
  bool get isCirclesLoading;

  PaginatedList<Circle> get lastUsedCircles;

  bool get isLoadingCollections;

  PaginatedList<Collection> get collections;

  PrivateProfile get privateProfile;

  PaginatedList<PodApp> get savedPods;

  bool get isLoadingPods;

  int get followersCount;

  int get followingCount;

  bool get isAndroid;
}

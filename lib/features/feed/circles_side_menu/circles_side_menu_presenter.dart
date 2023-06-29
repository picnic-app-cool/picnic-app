import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_stats_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_last_used_circles_use_case.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';

class CirclesSideMenuPresenter extends Cubit<CirclesSideMenuViewModel> {
  CirclesSideMenuPresenter(
    super.model,
    this.navigator,
    this._getLastUsedCirclesUseCase,
    this._getCollectionsUseCase,
    this._getSavedPodsUseCase,
    this._getUserStatsUseCase,
    this._getUserUseCase,
  );

  final CirclesSideMenuNavigator navigator;
  final GetLastUsedCirclesUseCase _getLastUsedCirclesUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final GetSavedPodsUseCase _getSavedPodsUseCase;
  final GetUserStatsUseCase _getUserStatsUseCase;
  final GetUserUseCase _getUserUseCase;

  // ignore: unused_element
  CirclesSideMenuPresentationModel get _model => state as CirclesSideMenuPresentationModel;

  Future<void> onInit() async {
    await _loadUserStats();
  }

  void onTapEnterCircle(Id circleId) {
    navigator.openCircleDetails(
      CircleDetailsInitialParams(
        circleId: circleId,
        onCircleMembershipChange: _onCircleUpdated,
      ),
    );
  }

  void onTapViewPods() => navigator.openDiscoverPods(const DiscoverPodsInitialParams());

  Future<void> loadSavedPods({bool fromScratch = false}) async {
    await _getSavedPodsUseCase
        .execute(
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.savedPods.nextPageCursor(),
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(savedPodsResult: result)),
        )
        .doOn(
          success: (pods) => fromScratch
              ? tryEmit(
                  _model.copyWith(savedPods: pods),
                )
              : tryEmit(
                  _model.copyWith(savedPods: _model.savedPods + pods),
                ),
        );
  }

  void onTapCollection(Collection collection) {
    navigator.openCollection(
      CollectionInitialParams(collection: collection, onPostRemovedCallback: () => loadCollection(fromScratch: true)),
      useRoot: true,
    );
  }

  void onTapViewCircles() =>
      navigator.openDiscoverCircles(DiscoverCirclesInitialParams(onCircleViewed: _onCircleUpdated));

  void onTapViewCollections() => navigator.openPrivateProfile(
        const PrivateProfileInitialParams(initialTab: PrivateProfileTab.collections),
      );

  Future<void> loadCollection({bool fromScratch = false}) => _getCollectionsUseCase
      .execute(
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.collectionCursor,
        userId: _model.privateProfile.id,
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(collectionsResult: result)),
      )
      .doOn(
        success: (list) => fromScratch
            ? tryEmit(_model.copyWith(collections: list))
            : tryEmit(
                _model.copyWith(collections: _model.collections + list),
              ),
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  void onTapSearchCircles() {
    navigator.openDiscoverExplore(const DiscoverExploreInitialParams());
  }

  Future<void> onLoadMoreCircles({bool fromScratch = false}) async {
    if (fromScratch) {
      await _loadLastUsedCircles(fromScratch: true);
    } else if (state.lastUsedCircles.hasNextPage) {
      await _loadLastUsedCircles();
    }
  }

  void onTapCreateNewCircle() {
    navigator.openCreateCircle(
      CreateCircleInitialParams(
        createCircleWithoutPost: true,
      ),
      useRoot: true,
    );
  }

  void onTapProfile() {
    navigator.openPrivateProfile(
      const PrivateProfileInitialParams(),
    );
  }

  Future<void> _loadLastUsedCircles({bool fromScratch = false}) async {
    await _getLastUsedCirclesUseCase
        .execute(
      cursor: fromScratch ? const Cursor.empty() : _model.lastUsedCirclesCursor,
    )
        .observeStatusChanges(
      (userCirclesResult) {
        tryEmit(_model.copyWith(lastUsedCirclesResult: userCirclesResult));
      },
    ).doOn(
      success: (list) {
        tryEmit(
          _model.copyWith(
            lastUsedCircles: fromScratch ? list : _model.lastUsedCircles.byAppending(list),
          ),
        );
      },
      fail: (fail) => navigator.showError(
        fail.displayableFailure(),
      ),
    );
  }

  void _onCircleUpdated() {
    onLoadMoreCircles(fromScratch: true);
  }

  Future<void> _loadUserStats() async {
    final userId = _model.privateProfile.id;
    await _getUserStatsUseCase //
        .execute(userId: userId)
        .doOn(
          success: (stats) => tryEmit(
            _model.copyWith(
              followingCount: stats.following,
            ),
          ),
        );
    await _getUserUseCase.execute(userId: userId).doOn(
          success: (user) => tryEmit(
            _model.copyWith(
              followersCount: user.followers,
            ),
          ),
        );
  }
}

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';

class CirclesSideMenuPresenter extends Cubit<CirclesSideMenuViewModel> {
  CirclesSideMenuPresenter(
    super.model,
    this.navigator,
    this._getUserCirclesUseCase,
    this._getCollectionsUseCase,
    this._getSavedPodsUseCase,
  );

  final CirclesSideMenuNavigator navigator;
  final GetUserCirclesUseCase _getUserCirclesUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final GetSavedPodsUseCase _getSavedPodsUseCase;

  // ignore: unused_element
  CirclesSideMenuPresentationModel get _model => state as CirclesSideMenuPresentationModel;

  void onTapEnterCircle(Id circleId) {
    _model.onCircleSideMenuAction();

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

  void onTapViewCircles() => navigator.openDiscoverCircles(const DiscoverCirclesInitialParams());

  void onTapViewCollections() => navigator.openPrivateProfile(
        const PrivateProfileInitialParams(),
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
    _model.onCircleSideMenuAction();

    navigator.openDiscoverExplore(const DiscoverExploreInitialParams());
  }

  void onTapShareCircleLink(String circleInviteLink) {
    _model.onCircleSideMenuAction();

    navigator.shareText(text: circleInviteLink);
  }

  Future<void> onLoadMoreCircles({bool fromScratch = false}) async {
    if (fromScratch) {
      await _loadUserCircles(fromScratch: true);
    } else if (state.userCircles.hasNextPage) {
      await _loadUserCircles();
    }
  }

  void onCreateNewCircleTap() {
    _model.onCircleSideMenuAction();

    navigator.openCreateCircle(
      CreateCircleInitialParams(
        createCircleWithoutPost: true,
      ),
      useRoot: true,
    );
  }

  Future<void> _loadUserCircles({bool fromScratch = false}) async {
    await _getUserCirclesUseCase.execute(
      nextPageCursor: fromScratch ? const Cursor.empty() : _model.userCirclesCursor,
      roles: [
        CircleRole.director,
        CircleRole.moderator,
        CircleRole.member,
      ],
    ).observeStatusChanges(
      (userCirclesResult) {
        tryEmit(_model.copyWith(userCirclesResult: userCirclesResult));
      },
    ).doOn(
      success: (list) {
        tryEmit(
          _model.copyWith(
            userCircles: fromScratch ? list : _model.userCircles.byAppending(list),
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
}

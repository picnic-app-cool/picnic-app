import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';

class CirclesSideMenuPresenter extends Cubit<CirclesSideMenuViewModel> {
  CirclesSideMenuPresenter(
    super.model,
    this.navigator,
    this._getUserCirclesUseCase,
  );

  final CirclesSideMenuNavigator navigator;
  final GetUserCirclesUseCase _getUserCirclesUseCase;

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

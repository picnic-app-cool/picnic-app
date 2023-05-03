import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/cursor_direction.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';

class DiscoverSearchResultsPresenter extends Cubit<DiscoverSearchResultsViewModel> {
  DiscoverSearchResultsPresenter(
    DiscoverSearchResultsPresentationModel model,
    this.navigator,
    this._searchUsersUseCase,
    this._getCirclesUseCase,
    this._joinCircleUseCase,
    this._followUnfollowUserUseCase,
    this._debouncer,
  ) : super(model);

  final DiscoverSearchResultsNavigator navigator;
  final SearchUsersUseCase _searchUsersUseCase;
  final GetCirclesUseCase _getCirclesUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUserUseCase;
  final Debouncer _debouncer;

  static const int _defaultCirclesSize = 5;
  static const int _defaultUsersSizes = 50;

  DiscoverSearchResultsPresentationModel get _model => state as DiscoverSearchResultsPresentationModel;

  void onTapJoinCircleButton(Circle circle) {
    _joinCircleUseCase.execute(circle: circle.toBasicCircle()).doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapFollowButton(PublicProfile user) {
    _followUnfollowUserUseCase
        .execute(
          userId: user.id,
          follow: !user.iFollow,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(followResult: result)),
        )
        .doOn(
          success: (success) => _handleFollowEvent(user),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onSearch(String query) {
    if (query == _model.query) {
      return;
    }

    tryEmit(
      _model.copyWith(
        query: query,
        isCirclesLoading: true,
        isUsersLoading: true,
      ),
    );
    _debouncer.debounce(
      const LongDuration(),
      () => _getSearchResult(),
    );
  }

  void onTapViewCircle(Id circleId) => navigator.openCircleDetails(
        CircleDetailsInitialParams(
          circleId: circleId,
          onCircleMembershipChange: () {
            tryEmit(
              _model.copyWith(
                circles: [],
              ),
            );
            _getCircles();
          },
        ),
      );

  void onTapViewProfile(Id id) {
    navigator.openProfile(userId: id);
  }

  void _handleFollowEvent(PublicProfile user) {
    final users = _model.users;
    final index = users.indexWhere((element) => element.id == user.id);
    final follower = users[index];
    tryEmit(_model.byUpdateFollowAction(follower));
  }

  void _getSearchResult() {
    _getCircles();
    _getUsers();
  }

  void _getUsers() {
    _searchUsersUseCase
        .execute(
          query: _model.query,
          ignoreMyself: true,
          nextPageCursor: const Cursor(
            id: Id.empty(),
            pageSize: _defaultUsersSizes,
            direction: CursorDirection.forward,
          ),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (list) => tryEmit(_model.copyWith(users: list.items, isUsersLoading: false)),
        );
  }

  void _getCircles() {
    _getCirclesUseCase
        .execute(
          query: _model.query,
          nextPageCursor: const Cursor(
            id: Id.empty(),
            pageSize: _defaultCirclesSize,
            direction: CursorDirection.forward,
          ),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (list) => tryEmit(_model.copyWith(circles: list.items, isCirclesLoading: false)),
        );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/get_followers_failure.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_followers_use_case.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';

class FollowersPresenter extends Cubit<FollowersViewModel> {
  FollowersPresenter(
    FollowersPresentationModel model,
    this.navigator,
    this._getFollowersUseCase,
    this._followUnfollowUseCase,
    this._debouncer,
  ) : super(model);

  final FollowersNavigator navigator;
  final GetFollowersUseCase _getFollowersUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  FollowersPresentationModel get _model => state as FollowersPresentationModel;

  void onTapToggleFollow(PublicProfile user) {
    _followUnfollowUseCase
        .execute(userId: user.id, follow: !user.iFollow) //
        .doOn(
          success: (success) => _handleFollowEvent(user),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(toggleFollowResult: result)),
        );
  }

  Future<void> onTapViewUserProfile(Id id) async {
    final profileUpdated = await navigator.openProfile(userId: id) ?? false;
    if (profileUpdated) {
      unawaited(loadFollowers(fromScratch: true));
    }
  }

  void onUserSearch(String query) {
    if (query == _model.searchQuery) {
      return;
    }

    tryEmit(_model.copyWith(searchQuery: query));
    _debouncer.debounce(
      const LongDuration(),
      () => loadFollowers(fromScratch: true),
    );
  }

  void onTapBack() => navigator.closeWithResult(true);

  Future<Either<GetFollowersFailure, PaginatedList<PublicProfile>>> loadFollowers({
    bool fromScratch = false,
  }) {
    return _getFollowersUseCase
        .execute(
          userId: _model.userId,
          searchQuery: _model.searchQuery,
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
        )
        .doOn(
          success: (followers) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(followers: followers)
                  : _model.byAppendingFollowersList(
                      newList: followers,
                    ),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _handleFollowEvent(PublicProfile user) {
    final users = _model.followers.items;
    final index = users.indexWhere((element) => element.id == user.id);
    final follower = users[index];
    tryEmit(_model.byUpdateFollowAction(follower));
  }
}

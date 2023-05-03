import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/ban_user_use_case.dart';

class BanUserListPresenter extends Cubit<BanUserListViewModel> {
  BanUserListPresenter(
    BanUserListPresentationModel model,
    this.navigator,
    this._banUserUseCase,
    this._searchUsersUseCase,
    this._debouncer,
  ) : super(model);

  final BanUserListNavigator navigator;
  final BanUserUseCase _banUserUseCase;

  final SearchUsersUseCase _searchUsersUseCase;

  final Debouncer _debouncer;

  BanUserListPresentationModel get _model => state as BanUserListPresentationModel;

  Future<void> loadMore() => _getUsers();

  void onTapClose() => navigator.close();

  void onSearchTextChanged(String value) {
    if (value != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () async {
          tryEmit(_model.copyWith(searchQuery: value));
          await _getUsers(fromScratch: true);
        },
      );
    }
  }

  Future<void> onTapUser(PublicProfile profile) async {
    await navigator.openProfile(userId: profile.id);
  }

  Future<void> onTapBan(PublicProfile user) async {
    final circleId = state.circle.id;
    final userBanned = await navigator.openBanUser(
      BanUserInitialParams(user: user, circleId: circleId),
    );

    if (userBanned == true) {
      await _banUserUseCase.execute(userId: user.id, circleId: circleId).doOn(
            success: (_) {
              tryEmit(_model.byBanUser(user.user));
              navigator.close();
            },
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
    }
  }

  Future<void> _getUsers({bool fromScratch = false}) {
    _model.searchUsersOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _searchUsersUseCase.execute(
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
        query: _model.searchQuery,
        ignoreMyself: true,
      ),
    );

    tryEmit(_model.copyWith(searchUsersOperation: operation));

    return operation.value.doOn(
      success: (users) => tryEmit(
        fromScratch ? _model.copyWith(usersList: users) : _model.byAppendingUsersList(users),
      ),
      fail: (fail) => navigator.showError(fail.displayableFailure()),
    );
  }
}

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/presentation/selectable_public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_navigator.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';

class AddMembersListPresenter extends Cubit<AddMembersListViewModel> {
  AddMembersListPresenter(
    super.model,
    this.navigator,
    this._searchUsersUseCase,
    this._debouncer,
  );

  final AddMembersListNavigator navigator;
  final SearchUsersUseCase _searchUsersUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  AddMembersListPresentationModel get _model => state as AddMembersListPresentationModel;

  void onTapClose() => navigator.close();

  void onSearchTextChanged(String value) {
    if (value != _model.searchText) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchText: value));
          loadMore(fromScratch: true);
        },
      );
    }
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    await _model.searchUsersOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _searchUsersUseCase.execute(
        query: _model.searchText,
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
      ),
    );

    tryEmit(_model.copyWith(searchUsersOperation: operation));

    await operation.value.doOn(
      success: (list) => tryEmit(
        fromScratch
            ? _model.copyWith(users: list.mapItems((it) => it.toSelectable()))
            : _model.byAppendingUsersList(list),
      ),
    );
  }

  Future<void> onTapAdd(PublicProfile publicProfile) async {
    if (_model.onAddUserResult.isPending()) {
      return;
    }
    final success = await _model
        .onAddUser(publicProfile.user) //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(onAddUserResult: result)),
        );
    if (success) {
      tryEmit(
        _model.bySelectingUser(publicProfile),
      );
    }
  }
}

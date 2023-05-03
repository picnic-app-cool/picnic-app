import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/selectable_public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/domain/use_cases/invite_user_to_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/search_non_member_users_use_case.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';

class InviteUserListPresenter extends Cubit<InviteUserListViewModel> {
  InviteUserListPresenter(
    InviteUserListPresentationModel model,
    this.navigator,
    this._inviteUserToCircleUseCase,
    this._searchNonMemberUsersUseCase,
    this._debouncer,
  ) : super(model);

  final InviteUserListNavigator navigator;
  final InviteUserToCircleUseCase _inviteUserToCircleUseCase;
  final SearchNonMemberUsersUseCase _searchNonMemberUsersUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  InviteUserListPresentationModel get _model => state as InviteUserListPresentationModel;

  void onTapClose() => navigator.close();

  void onSearchTextChanged(String value) {
    if (value != _model.searchText) {
      _debouncer.debounce(
        const LongDuration(),
        () async {
          tryEmit(_model.copyWith(searchText: value));
          await loadMore(fromScratch: true);
        },
      );
    }
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    await _model.searchMembersOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _searchNonMemberUsersUseCase.execute(
        searchQuery: _model.searchText,
        circleId: _model.circleId,
        cursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
      ),
    );

    tryEmit(_model.copyWith(searchMembersOperation: operation));

    await operation.value.doOn(
      success: (list) => tryEmit(
        fromScratch
            ? _model.copyWith(users: list.mapItems((it) => it.toSelectable()))
            : _model.byAppendingUsersList(list),
      ),
    );
  }

  Future<void> onTapInvite(PublicProfile user) async {
    if (_model.onInviteUserResult.isPending()) {
      return;
    }
    await _inviteUserToCircleUseCase
        .execute(
          input: InviteUsersToCircleInput(
            circleId: _model.circleId,
            userIds: [user.id],
          ),
        )
        .observeStatusChanges((result) => tryEmit(_model.copyWith(onInviteUserResult: result)))
        .doOn(
          success: (success) => tryEmit(_model.bySelectingUser(user)),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}

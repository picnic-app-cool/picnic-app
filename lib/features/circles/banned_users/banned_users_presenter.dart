import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_banned_users_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/unban_user_use_case.dart';

class BannedUsersPresenter extends Cubit<BannedUsersViewModel> {
  BannedUsersPresenter(
    super.model,
    this.navigator,
    this._getUnbanUserUseCase,
    this._getBannedUsersUseCase,
  );

  final BannedUsersNavigator navigator;
  final UnbanUserUseCase _getUnbanUserUseCase;
  final GetBannedUsersUseCase _getBannedUsersUseCase;

  // ignore: unused_element
  BannedUsersPresentationModel get _model => state as BannedUsersPresentationModel;

  Future<void> onTapUnban(BannedUser bannedUser) =>
      _getUnbanUserUseCase.execute(userId: bannedUser.userId, circleId: _model.circle.id).doOn(
            success: (_) => tryEmit(_model.byRemovingBan(bannedUser)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );

  Future<void> onTapBan() async {
    await navigator.openBanUserList(BanUserListInitialParams(circle: _model.circle));
    await _getBannedUsers(fromScratch: true);
  }

  Future<void> onTapBannedUser(BannedUser bannedUser) async {
    await _navigateToProfile(bannedUser.userId);
  }

  Future<void> onLoadMoreBannedUsers() => _getBannedUsers();

  void onSearchTextChanged(String value) => notImplemented();

  Future<void> _navigateToProfile(Id userId) async {
    await navigator.openProfile(userId: userId);
  }

  Future<void> _getBannedUsers({bool fromScratch = false}) {
    _model.getBannedUsersOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _getBannedUsersUseCase.execute(
        circleId: _model.circle.id,
        cursor: _model.bannedUsersCursor,
      ),
    );

    tryEmit(_model.copyWith(getBannedUsersOperation: operation));

    return operation.value.doOn(
      success: (users) => tryEmit(
        fromScratch ? _model.copyWith(bannedUsers: users) : _model.byAppendingBannedList(users),
      ),
      fail: (fail) => navigator.showError(fail.displayableFailure()),
    );
  }
}

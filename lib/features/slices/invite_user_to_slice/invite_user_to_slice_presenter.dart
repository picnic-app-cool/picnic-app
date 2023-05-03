import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/invite_user_to_circle_use_case.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_navigator.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presentation_model.dart';

class InviteUserToSlicePresenter extends Cubit<InviteUserToSliceViewModel> {
  InviteUserToSlicePresenter(
    InviteUserToSlicePresentationModel model,
    this.navigator,
    this._inviteUserToCircleUseCase,
    this._getCircleMembersUseCase,
    this._debouncer,
  ) : super(model);

  final InviteUserToSliceNavigator navigator;
  final InviteUserToCircleUseCase _inviteUserToCircleUseCase;
  final GetCircleMembersUseCase _getCircleMembersUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  InviteUserToSlicePresentationModel get _model => state as InviteUserToSlicePresentationModel;

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
    if (fromScratch) {
      tryEmit(_model.copyWith(users: const PaginatedList.empty()));
    }
    await _getCircleMembersUseCase
        .execute(
          searchQuery: _model.searchText,
          circleId: _model.circleId,
          cursor: _model.cursor,
        )
        .doOn(
          success: (list) => tryEmit(
            _model.byAppendingUsersList(list),
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

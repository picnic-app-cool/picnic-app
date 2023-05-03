import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_by_role_use_case.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_navigator.dart';
import 'package:picnic_app/features/circles/members/members_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class MembersPresenter extends Cubit<MembersPageViewModel> with SubscriptionsMixin {
  MembersPresenter(
    MembersPresentationModel model,
    this.navigator,
    this._followUnfollowUseCase,
    this._getMembersByRoleUseCase,
    this._clipboardManager,
    this._debouncer,
  ) : super(model);
  final MembersNavigator navigator;
  final FollowUnfollowUserUseCase _followUnfollowUseCase;
  final GetCircleMembersByRoleUseCase _getMembersByRoleUseCase;
  final ClipboardManager _clipboardManager;
  final Debouncer _debouncer;

  // ignore: unused_element
  MembersPresentationModel get _model => state as MembersPresentationModel;

  void onTapToggleFollow(CircleMember member) {
    _followUnfollowUseCase
        .execute(userId: member.user.id, follow: !member.user.iFollow)
        .doOn(success: (success) => _handleFollowEvent(member.user))
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(toggleFollowResult: result)),
        )
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onTapEditRole(CircleMember member) async {
    await navigator.openUserRoles(
      UserRolesInitialParams(
        user: member.user,
        circleId: _model.circle.id,
      ),
    );
    await _loadMembers(fromScratch: true);
  }

  Future<void> onTapViewUserProfile(CircleMember circleMember) async {
    final profileUpdated = await navigator.openProfile(userId: circleMember.user.id) ?? false;
    if (profileUpdated) {
      await onLoadMoreMembers(fromScratch: true);
    }
  }

  void onUserSearch(String value) {
    if (value != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchQuery: value));
          onLoadMoreMembers(fromScratch: true);
        },
      );
    }
  }

  Future<void> onLoadMoreMembers({bool fromScratch = false}) async {
    await _model.membersSearchOperation?.cancel();
    if (fromScratch) {
      await _loadDirectors(fromScratch: true);
    } else if (state.directors.hasNextPage) {
      await _loadDirectors();
    } else if (state.members.hasNextPage) {
      await _loadMembers();
    }
  }

  void onTapInviteUsers() => navigator.openInviteUsersBottomSheet(
        onTapClose: navigator.close,
        onTapCopyLink: () async {
          await _clipboardManager.saveText(_model.circle.inviteCircleLink);
          navigator.close();
          await navigator.showSnackBar(appLocalizations.invitationLinkCopiedMessage);
        },
        onTapInvite: () => navigator.openInviteUserList(
          InviteUserListInitialParams(circleId: _model.circle.id),
        ),
      );

  void onTapAddRole() => navigator.openCircleRole(
        CircleRoleInitialParams(
          circleId: _model.circle.id,
          formType: CircleRoleFormType.createCircleRole,
        ),
      );

  Future<void> _loadDirectors({bool fromScratch = false}) async {
    final operation = CancelableOperation.fromFuture(
      _getMembersByRoleUseCase.execute(
        circleId: _model.circle.id,
        cursor: fromScratch ? const Cursor.firstPage() : _model.directorsCursor,
        roles: [CircleRole.director],
        searchQuery: _model.searchQuery,
      ),
    );
    await operation.value.doOn(
      fail: (failure) => navigator.showError(failure.displayableFailure()),
      success: (directors) => tryEmit(
        fromScratch
            ? _model.copyWith(directors: directors, members: const PaginatedList.empty())
            : _model.byAppendingDirectorsList(directors),
      ),
    );
    if (!_model.directors.hasNextPage) {
      await _loadMembers();
    }
  }

  Future<void> _loadMembers({bool fromScratch = false}) async {
    if (fromScratch) {
      tryEmit(_model.copyWith(members: const PaginatedList.empty()));
    }
    final operation = CancelableOperation.fromFuture(
      _getMembersByRoleUseCase.execute(
        circleId: _model.circle.id,
        cursor: fromScratch ? const Cursor.firstPage() : _model.membersCursor,
        roles: [CircleRole.member, CircleRole.moderator],
        searchQuery: _model.searchQuery,
      ),
    );

    await operation.value.doOn(
      fail: (failure) => navigator.showError(failure.displayableFailure()),
      success: (members) => tryEmit(_model.byAppendingMembersList(members)),
    );
  }

  void _handleFollowEvent(PublicProfile user) {
    final users = _model.members.items;
    final index = users.indexWhere((element) => element.user.id == user.id);
    final members = users.toList();
    tryEmit(_model.byUpdateFollowAction(members[index]));
  }
}

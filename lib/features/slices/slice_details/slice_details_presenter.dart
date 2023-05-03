import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/use_cases/get_slice_members_by_role_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/circles/widgets/invite_user_bottom_sheet.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class SliceDetailsPresenter extends Cubit<SliceDetailsViewModel> {
  SliceDetailsPresenter(
    SliceDetailsPresentationModel model,
    this._getSliceMembersByRoleUseCase,
    this.navigator,
    this._clipboardManager,
    this._debouncer,
  ) : super(model);

  final SliceDetailsNavigator navigator;

  final Debouncer _debouncer;

  final ClipboardManager _clipboardManager;

  final GetSliceMembersByRoleUseCase _getSliceMembersByRoleUseCase;

  SliceDetailsPresentationModel get _model => state as SliceDetailsPresentationModel;

  //TODO logic to be implemented here https://picnic-app.atlassian.net/browse/GS-5337
  void onTapChat() => notImplemented();

  void onTapJoin() {
    if (state.iJoined) {
      if (state.isPrivate && state.canApproveRequests) {
        navigator.openJoinRequests(JoinRequestsInitialParams(sliceId: _model.slice.id));
      }
    }
  }

  Future<void> onTapMore() async {
    final result = await navigator
        .openSliceSettingsBottomSheet(SliceSettingsInitialParams(circle: _model.circle, slice: _model.slice));
    if (result == SliceSettingsPageResult.didLeftSlice) {
      navigator.closeWithResult(SliceSettingsPageResult.didLeftSlice);
    }
  }

  void onTabChanged(int index) => tryEmit(
        _model.copyWith(selectedTab: _model.tabs[index]),
      );

  void onTapMember(SliceMember sliceMember) => _onTapUser(sliceMember);

  Future<void> onTapReportToCircleOwners() async {
    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            reportEntityType: ReportEntityType.slice,
            sliceId: _model.slice.id,
          ),
        ) ??
        false;
    if (reportSuccessful) {
      navigator.close();
    }
  }

  Future<void> onTapEditRules() async {
    final updatedSlice = await navigator.openEditSliceRules(EditSliceRulesInitialParams(_model.slice));
    if (updatedSlice != null) {
      tryEmit(_model.byUpdatingSliceRules(updatedSlice.rules));
    }
  }

  void onSearchTextChanged(String value) {
    if (value != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () async {
          tryEmit(_model.copyWith(searchQuery: value));
          await _getUsers(fromScratch: true);
          await _getModerators(fromScratch: true);
        },
      );
    }
  }

  void onTapInviteUsers() => showPicnicBottomSheet(
        InviteUserBottomSheet(
          onTapClose: () => navigator.close(),
          onTapCopyLink: () async {
            await _clipboardManager.saveText(_model.circle.inviteCircleLink);
            navigator.close();
            await navigator.showSnackBar(appLocalizations.invitationLinkCopiedMessage);
          },
          onTapInvite: () {
            navigator.openInviteUserList(
              InviteUserToSliceInitialParams(circleId: _model.circle.id, sliceId: _model.slice.id),
            );
          },
        ),
      );

  Future<void> loadMoreMembers() async {
    if (_model.moderators.hasNextPage) {
      await _getModerators();
    } else if (_model.users.hasNextPage) {
      await _getUsers();
    }
  }

  Future<void> _onTapUser(SliceMember sliceMember) async {
    await navigator.openProfile(userId: sliceMember.user.id);
  }

  Future<void> _getModerators({bool fromScratch = false}) {
    if (fromScratch) {
      tryEmit(_model.copyWith(users: const PaginatedList.empty()));
    }
    return _getSliceMembersByRoleUseCase
        .execute(
          sliceId: _model.slice.id,
          nextPageCursor: _model.sliceModeratorCursor,
          roles: [
            SliceRole.owner,
            SliceRole.director,
            SliceRole.moderator,
          ],
          searchQuery: _model.searchQuery,
        )
        .doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (moderators) => tryEmit(_model.byAppendingModeratorsList(moderators)),
        );
  }

  Future<void> _getUsers({bool fromScratch = false}) {
    if (fromScratch) {
      tryEmit(_model.copyWith(users: const PaginatedList.empty()));
    }
    return _getSliceMembersByRoleUseCase
        .execute(
          sliceId: _model.slice.id,
          nextPageCursor: _model.sliceModeratorCursor,
          roles: [SliceRole.member],
          searchQuery: _model.searchQuery,
        )
        .doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (users) => tryEmit(_model.byAppendingUsersList(users)),
        );
  }
}

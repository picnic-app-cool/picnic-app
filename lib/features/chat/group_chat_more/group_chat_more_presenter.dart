import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_page_result.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_tab.dart';
import 'package:picnic_app/features/chat/domain/use_cases/add_user_to_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_members_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/leave_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/remove_user_from_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_name_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_navigator.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class GroupChatMorePresenter extends Cubit<GroupChatMoreViewModel> {
  GroupChatMorePresenter(
    super.model,
    this.navigator,
    this._getChatMembersUseCase,
    this._getChatSettingsUseCase,
    this._updateChatSettingsUseCase,
    this._updateChatNameUseCase,
    this._addUserToChatUseCase,
    this._removeUserFromChatUseCase,
    this._leaveChatUseCase,
    this._debouncer,
  );

  final GroupChatMoreNavigator navigator;
  final GetChatMembersUseCase _getChatMembersUseCase;

  final GetChatSettingsUseCase _getChatSettingsUseCase;
  final UpdateChatSettingsUseCase _updateChatSettingsUseCase;
  final UpdateChatNameUseCase _updateChatNameUseCase;
  final AddUserToChatUseCase _addUserToChatUseCase;
  final RemoveUserFromChatUseCase _removeUserFromChatUseCase;
  final LeaveChatUseCase _leaveChatUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  GroupChatMorePresentationModel get _model => state as GroupChatMorePresentationModel;

  void onInit() {
    _getChatSettings();
  }

  void onTabChanged(GroupChatMoreTab tab) => tryEmit(
        _model.copyWith(selectedTab: tab),
      );

  Future<void> onTapReport() async {
    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            entityId: _model.chat.id,
            reportEntityType: ReportEntityType.chat,
          ),
        ) ??
        false;
    if (reportSuccessful) {
      navigator.close();
    }
  }

  Future<void> onTapAddMembers() async {
    await navigator.openAddMembersList(AddMembersListInitialParams(onAddUser: _onAddUser));
  }

  void onTapLeave() => navigator.showConfirmationBottomSheet(
        title: appLocalizations.leaveGroupTitle,
        message: appLocalizations.leaveGroupMessage,
        primaryAction: ConfirmationAction(
          title: appLocalizations.leaveGroupAction,
          action: () {
            navigator.close();
            _leaveChat();
          },
        ),
        secondaryAction: ConfirmationAction.negative(
          action: () => navigator.close(),
        ),
      );

  void onTapUser(ChatMember member) => navigator.openPublicProfile(PublicProfileInitialParams(userId: member.userId));

  void onTapRemoveMember(ChatMember member) {
    final user = member.user;
    navigator.showRemoveMemberConfirmation(
      onTapRemove: () {
        navigator.close();
        _removeMember(member);
      },
      user: user,
    );
  }

  void onGroupNameChanged(String groupName) {
    if (groupName != _model.groupName) {
      _debouncer.debounce(
        const LongDuration(),
        () => _updateChatName(groupName),
      );
    }
  }

  void onSwitchNotificationChanged({bool enabled = false}) {
    final newChatSettings = _model.chatSettings.copyWith(
      isMuted: enabled,
    );
    _updateChatSettingsUseCase
        .execute(
          chatId: _model.chat.id,
          chatSettings: newChatSettings,
        )
        .doOn(
          success: (_) => tryEmit(
            _model.copyWith(
              chatSettings: newChatSettings,
            ),
          ),
        );
  }

  Future<void> loadMoreMembers({bool fromScratch = false}) async {
    await _model.getChatMembersOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _getChatMembersUseCase.execute(
        chatId: _model.chat.id,
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
      ),
    );

    tryEmit(_model.copyWith(getChatMembersOperation: operation));

    await operation.value.doOn(
      success: (list) => tryEmit(
        fromScratch ? _model.copyWith(members: list) : _model.byAppendingMembersList(list),
      ),
    );
  }

  Future<bool> _onAddUser(User user) {
    return _addUserToChatUseCase
        .execute(
      chatId: _model.chat.id,
      userId: user.id,
    )
        .asyncFold(
      (fail) => false,
      (success) {
        _updateChat(
          _model.chat.copyWith(participantsCount: _model.chat.participantsCount + 1),
        );
        loadMoreMembers(fromScratch: true);
        return true;
      },
    );
  }

  void _leaveChat() => _leaveChatUseCase
      .execute(
        chatId: _model.chat.id,
      )
      .doOn(
        success: (_) => navigator.closeWithResult(GroupChatMorePageResult.groupAbandoned),
      );

  void _getChatSettings() => _getChatSettingsUseCase
      .execute(
        chatId: _model.chat.id,
      )
      .doOn(
        success: (result) => tryEmit(
          _model.copyWith(
            chatSettings: result,
          ),
        ),
      );

  void _updateChatName(String groupName) => _updateChatNameUseCase
      .execute(
        chatId: _model.chat.id,
        name: groupName,
      )
      .doOn(
        success: (_) => _updateChat(
          _model.chat.copyWith(name: groupName),
        ),
      );

  void _removeMember(ChatMember member) {
    if (_model.members.items.contains(member)) {
      _removeUserFromChatUseCase
          .execute(
            chatId: _model.chat.id,
            userId: member.userId,
          )
          .doOn(
            success: (_) => tryEmit(
              _model.byRemovingMember(member),
            ),
          );
    }
  }

  void _updateChat(BasicChat chat) {
    tryEmit(
      _model.copyWith(chat: chat),
    );
    _model.onChatChanged?.call(chat);
  }
}

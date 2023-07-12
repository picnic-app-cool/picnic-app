import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presenter.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_navigator.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chats_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_single_chat_recipient_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/leave_chat_use_case.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';

class ChatDmsPresenter extends Cubit<ChatDmsViewModel> with SubscriptionsMixin {
  ChatDmsPresenter(
    ChatDmsViewModel model,
    this.navigator,
    this._getChatsUseCase,
    this._leaveChatUseCase,
    this._getSingleChatRecipientUseCase,
    this._logAnalyticsEventUseCase,
    this._userStore,
    UnreadCountersStore unreadCountersStore,
  ) : super(model) {
    listenTo<List<UnreadChat>>(
      stream: unreadCountersStore.stream,
      subscriptionId: _unreadCountersStoreSubscription,
      onChange: (list) => _updateUnreadChats(list),
    );
  }

  final ChatDmsNavigator navigator;

  static const _unreadCountersStoreSubscription = "unreadCountersStoreDmsSubscription";

  late final _chatsPresenter = PaginatedListPresenter<ChatListItemDisplayable>(
    getPresentationModel: () => _model.chats,
    modelUpdatedCallback: (chats) => tryEmit(_model.copyWith(chats: chats)),
    loadMoreFunction: (searchText, cursor) => _getChatsUseCase
        .execute(
          searchQuery: searchText,
          chatTypes: [ChatType.group, ChatType.single],
          nextPageCursor: cursor,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(chatResults: result)),
        )
        .mapSuccess(
          (chats) => chats.mapItems(
            (chat) => chat.toChatListItemDisplayable(_userStore.privateProfile.user.id),
          ),
        ),
  );

  final GetChatsUseCase _getChatsUseCase;
  final GetSingleChatRecipientUseCase _getSingleChatRecipientUseCase;
  final LeaveChatUseCase _leaveChatUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final UserStore _userStore;

  ChatDmsPresentationModel get _model => state as ChatDmsPresentationModel;

  Future<void> loadMore({bool fromScratch = false}) async {
    if (!_model.isLoadingChat) {
      await _chatsPresenter.loadMore(fromScratch: fromScratch);
    }
  }

  void onChangedSearchText(String value) => _chatsPresenter.onChangedSearchText(value);

  void onTapChat(BasicChat chat) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatDmsListTap,
        targetValue: chat.chatType.value,
      ),
    );
    switch (chat.chatType) {
      case ChatType.single:
        _openSingleChat(chat);
        break;
      case ChatType.circle:
        notImplemented();
        break;
      case ChatType.group:
        _openGroupChat(chat);
        break;
    }
  }

  void onTapCreateNewMessage() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatDmsNewMassageTap,
      ),
    );
    navigator.openNewMessage(const NewMessageInitialParams());
  }

  void viewDidAppear() {
    if (!_model.ignoreViewDidAppear) {
      _chatsPresenter.loadMore(fromScratch: true);
    }
    tryEmit(
      _model.copyWith(
        ignoreViewDidAppear: false,
      ),
    );
  }

  Future<void> onTapConfirmLeaveChat(BasicChat chat) =>
      navigator.showConfirmLeaveChatRoute(onTapLeave: () => _leaveChat(chat));

  void _updateUnreadChats(List<UnreadChat> unreadChats) {
    //Reload the whole list to update every single chat and have a correct order from the BE
    loadMore(fromScratch: true);
  }

  void _leaveChat(BasicChat chat) => _leaveChatUseCase.execute(chatId: chat.id).doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (result) => tryEmit(_model.byRemovingChat(chat)),
      );

  Future<void> _openSingleChat(BasicChat chat) async {
    await _getSingleChatRecipientUseCase
        .execute(chatId: chat.id)
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(chatOpenResult: result)),
        )
        .doOnSuccessWait(
          (user) => navigator.openSingleChat(
            SingleChatInitialParams(chat: chat),
          ),
        );
  }

  Future<void> _openGroupChat(BasicChat chat) async =>
      navigator.openGroupChat(GroupChatInitialParams.fromExistingChat(chat: chat));
}

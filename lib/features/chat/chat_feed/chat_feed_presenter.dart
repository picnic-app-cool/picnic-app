import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presenter.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_navigator.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_feeds_use_case.dart';
import 'package:picnic_app/features/chat/utils/live_chats_presenter.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';

class ChatFeedPresenter extends Cubit<ChatFeedViewModel> {
  ChatFeedPresenter(
    super.model,
    this.navigator,
    this._getChatFeedsUseCase,
    this._logAnalyticsEventUseCase,
    this._liveChatPresenter,
  );

  final ChatFeedNavigator navigator;
  final GetChatFeedsUseCase _getChatFeedsUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  final LiveChatsPresenter _liveChatPresenter;

  late final _chatExcerptsPresenter = PaginatedListPresenter<ChatExcerpt>(
    getPresentationModel: () => _model.chatExcerpts,
    modelUpdatedCallback: (chatExcerpts) {
      tryEmit(_model.copyWith(chatExcerpts: chatExcerpts));
      _liveChatPresenter.subscribeToChannels(
        chatIds: chatExcerpts.paginatedList.items.map((e) => e.id).toList(),
      );
    },
    loadMoreFunction: (_, cursor) => _getChatFeedsUseCase
        .execute(
          nextPageCursor: cursor,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(chatExcerptsResults: result)),
        ),
  );

  ChatFeedPresentationModel get _model => state as ChatFeedPresentationModel;

  Future<void> onInit() async {
    await _liveChatPresenter.onInit(
      getChatMessagesProvider: _getChatMessagesProvider,
      onChatMessagesUpdatedCallback: _onChatMessagesUpdatedCallback,
    );
  }

  @override
  Future<void> close() {
    _liveChatPresenter.dispose();
    return super.close();
  }

  Future<void> refresh() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatFeedPullToRefresh,
      ),
    );
    await loadMore(fromScratch: true);
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    if (!_model.isLoadingChatExcerpts) {
      await _chatExcerptsPresenter.loadMore(fromScratch: fromScratch);
    }
  }

  void onTapFeed(Circle circle) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatFeedChatTap,
        targetValue: circle.chat.id.value,
      ),
    );
    navigator.openCircleChat(
      CircleChatInitialParams(
        chat: circle.chat.toChat(circle: circle.toBasicCircle()),
      ),
    );
  }

  Future<void> onTapCircle(Circle circle) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatFeedCircleTap,
        targetValue: circle.chat.id.value,
      ),
    );
    await navigator.openCircleDetails(
      CircleDetailsInitialParams(circleId: circle.id),
    );
  }

  void viewDidAppear() {
    if (!_model.ignoreViewDidAppear) {
      _chatExcerptsPresenter.loadMore(fromScratch: true);
    }
    tryEmit(
      _model.copyWith(
        ignoreViewDidAppear: false,
      ),
    );
  }

  Future<void> onAppLifecycleStateChange(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      await _liveChatPresenter.disconnect();
    } else if (state == AppLifecycleState.resumed) {
      await _liveChatPresenter.connect();
      viewDidAppear();
    }
  }

  List<ChatMessage>? _getChatMessagesProvider({required Id chatId}) =>
      _model.chatExcerpts.paginatedList.items.firstWhereOrNull((chatExcerpt) => chatExcerpt.id == chatId)?.messages;

  void _onChatMessagesUpdatedCallback({required Id chatId, required List<ChatMessage> chatMessages}) {
    final newPaginatedList = _model.chatExcerpts.paginatedList.byUpdatingItem(
      itemFinder: (chatExcerpt) => chatExcerpt.id == chatId,
      update: (chatExcerpt) => chatExcerpt.copyWith(messages: chatMessages),
    );

    tryEmit(
      _model.copyWith(
        chatExcerpts: _model.chatExcerpts.copyWith(paginatedList: newPaginatedList),
      ),
    );
  }
}

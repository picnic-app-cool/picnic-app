import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_navigator.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_circle_chats_use_case.dart';

class ChatMyCirclesPresenter extends Cubit<ChatMyCirclesViewModel> {
  ChatMyCirclesPresenter(
    super.model,
    this.navigator,
    this._getCircleChatsUseCase,
    this._debouncer,
  );

  final ChatMyCirclesNavigator navigator;
  final GetCircleChatsUseCase _getCircleChatsUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  ChatMyCirclesPresentationModel get _model => state as ChatMyCirclesPresentationModel;

  void onChangedSearchText(String value) {
    if (value != _model.circlesSearchText) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(circlesSearchText: value));
          loadMore(fromScratch: true);
        },
      );
    }
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    if (!_model.isLoadingChat) {
      await _getCircleChats(fromScratch);
    }
  }

  void viewDidAppear() {
    if (!_model.ignoreViewDidAppear) {
      loadMore(fromScratch: true);
    }
    tryEmit(
      _model.copyWith(
        ignoreViewDidAppear: false,
      ),
    );
  }

  Future<void> onTapCircle(BasicChat chat) async {
    final circleChat = _model.circleChats.items.firstWhereOrNull((element) => element.id == chat.id);
    if (circleChat != null) {
      unawaited(
        navigator.openCircleChat(
          CircleChatInitialParams(
            chat: circleChat,
          ),
        ),
      );
    }
  }

  Future<void> _getCircleChats(bool fromScratch) => _getCircleChatsUseCase
      .execute(
        searchQuery: _model.circlesSearchText,
        nextPageCursor:
            fromScratch ? const Cursor.firstPage().copyWith(limit: Cursor.extendedPageSize) : _model.nextPageCursor,
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(chatResults: result)),
      )
      .doOn(
        success: (list) => tryEmit(
          fromScratch ? _model.copyWith(circleChats: list) : _model.byAppendingCirclesList(list),
        ),
      );
}

import 'dart:async';
import 'dart:ui';

import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_updated_event.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/start_unread_chats_listening_use_case.dart';
import 'package:picnic_app/features/in_app_events/in_app_event_presentable.dart';

class UnreadChatsPresenter implements InAppEventPresentable {
  UnreadChatsPresenter(
    this._startUnreadChatsListeningUseCase,
    this._unreadCountersStore,
  );

  final StartUnreadChatsListeningUseCase _startUnreadChatsListeningUseCase;
  final UnreadCountersStore _unreadCountersStore;
  late final StreamSubscription<LiveEvent<ChatEvent>> _subscription;

  @override
  Future<void> onInit() async {
    await _startUnreadUpdatesListening();
  }

  @override
  Future<void> dispose() async {
    unawaited(_subscription.cancel());
  }

  @override
  void onAppLifecycleStateChange(AppLifecycleState state) {
    doNothing();
  }

  Future<void> _startUnreadUpdatesListening() async {
    final stream = await _startUnreadChatsListeningUseCase.execute();
    _subscription = stream.listen((event) {
      final chatUpdatedEvent = event.event;
      //In this case we know that only event type which we can receive here is ChatUpdatedEvent.
      //For security reasons we have type check.
      if (chatUpdatedEvent is ChatUpdatedEvent) {
        final unreadChat = UnreadChat.fromChatUpdatedEvent(chatUpdatedEvent);
        _unreadCountersStore.add(unreadChat);
      }
    });
  }
}

import 'package:picnic_app/core/domain/model/live_event/channel_live_event.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

abstract class LiveEvent<T> {
  LiveEventType get type;

  T get event;

  void when({
    Function(T event)? broadcastEventReceived,
    Function(T event, Id channelId)? channelEventReceived,
  }) {
    switch (type) {
      case LiveEventType.broadcast:
        broadcastEventReceived?.call(event);
        return;
      case LiveEventType.channel:
        channelEventReceived?.call(event, (this as ChannelLiveEvent).channelId);
        return;
    }
  }
}

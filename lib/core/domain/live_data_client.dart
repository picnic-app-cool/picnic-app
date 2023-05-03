import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// Live data client allows for listening for live events coming from backend.
/// it supports server-wide events by default as well as subscribing to channels with subscriptions.
/// for now, adding subscriptions is additive and contributes to the pool of all events this client is connected to
abstract class LiveDataClient<T> {
  Stream<LiveEvent<T>> get eventsStream;

  Future<void> subscribeToChannel(Id channelId);

  Future<void> dispose();

  Future<void> disconnect();

  Future<void> connect();
}

typedef LiveDataClientParserCallback<T> = T Function(Map<String, dynamic>);

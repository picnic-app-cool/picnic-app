import 'dart:async';
import 'dart:convert';

import 'package:centrifuge/centrifuge.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/model/connection_status_changed_event.dart';
import 'package:picnic_app/core/domain/model/live_event/broadcast_live_event.dart';
import 'package:picnic_app/core/domain/model/live_event/channel_live_event.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/domain/model/centrifuge_connection_status.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CentrifugeClient<T> implements LiveDataClient<T> {
  CentrifugeClient(this._eventParser);

  late Client _client;
  late StreamController<LiveEvent<T>> _eventsController;
  late StreamController<ConnectionStatusChangedEvent> _connectionStatusController;

  StreamSubscription<ConnectedEvent>? _connectedSubscription;
  StreamSubscription<ConnectingEvent>? _connectingSubscription;
  StreamSubscription<DisconnectedEvent>? _disconnectedSubscription;
  StreamSubscription<ServerPublicationEvent>? _publicationSubscription;
  StreamSubscription<ErrorEvent>? _errorSubscription;

  final Map<Id, StreamSubscription<dynamic>> _subscriptionSubs = {};

  final LiveDataClientParserCallback<T?> _eventParser;

  @override
  Stream<LiveEvent<T>> get eventsStream => _eventsController.stream;

  State get connectionState => _client.state;

  Future<void> init({
    required String token,
    required String uri,
  }) async {
    _eventsController = StreamController<LiveEvent<T>>(
      //Dispose all subscriptions when there is no longer active listeners
      onCancel: () => dispose(),
    );

    _connectionStatusController = StreamController<ConnectionStatusChangedEvent>(
      //Dispose all subscriptions when there is no longer active listeners
      onCancel: () => dispose(),
    );

    _client = createClient(
      uri,
      ClientConfig(token: token),
    );

    _listenConnecting();
    _listenConnected();
    _listenDisconnected();
    _listenError();
    _listenServerPublication();
  }

  @override
  Future<void> connect() => _client.connect();

  @override
  Future<void> disconnect() => _client.disconnect();

  @override
  Future<void> subscribeToChannel(Id channel) async {
    if (_client.getSubscription(channel.value) != null) {
      //we're already subscribed to that subscription
      return;
    }
    final subscription = _client.newSubscription(channel.value, SubscriptionConfig());
    _subscriptionSubs[channel] = subscription.publication.listen((event) {
      _onMessageReceived(
        data: event.data,
        channelId: channel,
      );
    });
    await subscription.subscribe();
  }

  @override
  Future<void> dispose() async {
    await _connectingSubscription?.cancel();
    await _connectedSubscription?.cancel();
    await _disconnectedSubscription?.cancel();
    await _publicationSubscription?.cancel();
    await _errorSubscription?.cancel();
    for (final sub in _subscriptionSubs.values) {
      await sub.cancel();
    }
  }

  void _listenServerPublication() {
    _publicationSubscription = _client.publication.listen((event) => _onMessageReceived(data: event.data));
  }

  void _listenError() {
    _errorSubscription = _client.error.listen((event) {
      debugLog(event.error.toString());
      _emitStatusChanged(CentrifugeConnectionStatus.error);
    });
  }

  void _listenDisconnected() {
    _disconnectedSubscription = _client.disconnected.listen((_) {
      _emitStatusChanged(CentrifugeConnectionStatus.disconnected);
    });
  }

  void _listenConnected() {
    _connectedSubscription = _client.connected.listen((_) {
      _emitStatusChanged(CentrifugeConnectionStatus.connected);
    });
  }

  void _listenConnecting() {
    _connectingSubscription = _client.connecting.listen((_) {
      _emitStatusChanged(CentrifugeConnectionStatus.connecting);
    });
  }

  void _emitStatusChanged(CentrifugeConnectionStatus status) {
    _connectionStatusController.add(
      ConnectionStatusChangedEvent(status: status),
    );
  }

  Map<String, dynamic> _parseEvent(List<int> data) {
    final jsonString = utf8.decode(data);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  void _onMessageReceived({
    required List<int> data,
    Id? channelId,
  }) {
    final parsedData = _parseEvent(data);
    final payload = _eventParser(parsedData);
    if (payload == null) {
      return;
    }

    if (channelId != null) {
      _eventsController.add(
        ChannelLiveEvent(
          event: payload,
          channelId: channelId,
        ),
      );
    } else {
      _eventsController.add(
        BroadcastLiveEvent(
          event: payload,
        ),
      );
    }
  }
}

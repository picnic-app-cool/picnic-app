import 'dart:async';

import 'package:centrifuge/centrifuge.dart';
import 'package:picnic_app/core/data/centrifuge/centrifuge_client.dart';
import 'package:picnic_app/core/data/centrifuge/centrifuge_client_factory.dart';
import 'package:picnic_app/core/data/model/notification_payload.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/data/model/subscription_chat_payload_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CentrifugeRepository implements LiveEventsRepository {
  CentrifugeRepository(
    this.centrifugeClientFactory,
    this._authTokenRepository,
    this._envConfigProvider,
  );

  final CentrifugeClientFactory centrifugeClientFactory;
  final AuthTokenRepository _authTokenRepository;
  final EnvironmentConfigProvider _envConfigProvider;

  String? _accessToken;
  CentrifugeClient<Notification>? _notificationsClient;

  final _filters = <NotificationsFilter>{};

  @override
  void addNotificationsFilter(NotificationsFilter filter) {
    _filters.add(filter);
  }

  @override
  void removeNotificationsFilter(NotificationsFilter filter) {
    _filters.remove(filter);
  }

  @override
  Future<LiveDataClient<ChatEvent>> getChatLiveDataClient() async {
    final env = await _envConfigProvider.getConfig();
    final client = centrifugeClientFactory.createClient<ChatEvent>(
      eventParser: (parsedData) => SubscriptionChatPayloadJson.fromJson(json: parsedData).toChatEvent(),
    );

    await _readAccessToken();
    await _initClient(
      token: _accessToken ?? "",
      uri: env.baseChatUri,
      client: client,
    );

    return client;
  }

  @override
  Future<Stream<Notification>> getInAppNotificationEvents() async {
    Stream<Notification> notificationStream(CentrifugeClient<Notification> client) => client.eventsStream
        .map((event) => event.event)
        .where((notification) => _filters.every((filter) => !filter(notification)));

    final env = await _envConfigProvider.getConfig();
    _notificationsClient = centrifugeClientFactory.createClient<Notification>(
      eventParser: (parsedData) => NotificationPayload.fromJson(parsedData).toNotification(),
    );
    await _readAccessToken();
    await _initClient(
      token: _accessToken ?? "",
      uri: env.baseInAppNotificationsUri,
      client: _notificationsClient!,
    );

    return notificationStream(_notificationsClient!);
  }

  @override
  Future<void> switchInAppNotifications({required bool enable}) async {
    final client = _notificationsClient;
    if (client != null && client.connectionState != State.connecting) {
      enable ? await client.connect() : await client.disconnect();
    }
  }

  @override
  Future<Stream<LiveEvent<ChatEvent>>> startUnreadChatUpdateListening(Id userId) async {
    final env = await _envConfigProvider.getConfig();
    final client = centrifugeClientFactory.createClient<ChatEvent>(
      eventParser: (parsedData) => SubscriptionChatPayloadJson.fromJson(json: parsedData).toChatEvent(),
    );

    await _readAccessToken();
    await _initClient(
      token: _accessToken ?? "",
      uri: env.baseChatUri,
      client: client,
    );

    await client.subscribeToChannel(userId);
    return client.eventsStream;
  }

  Future<void> _readAccessToken() async {
    _accessToken = await _authTokenRepository.getAuthToken().asyncFold(
          (fail) => '',
          (token) => token.accessToken,
        );

    _authTokenRepository //
        .listenAuthToken()
        .listen(
          (token) => _accessToken = token.accessToken,
          onError: (fail) => logError(fail),
        );
  }

  Future<void> _initClient<T>({
    required String token,
    required String uri,
    required CentrifugeClient<T> client,
  }) async {
    await client.init(token: token, uri: uri);
    await client.connect();
  }
}

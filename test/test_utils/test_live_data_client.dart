import 'dart:async';

import 'package:centrifuge/centrifuge.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class TestLiveDataClient<T> implements LiveDataClient<T> {
  final streamController = StreamController<LiveEvent<T>>();
  final List<Id> channelSubscriptions = [];
  late Client client;

  @override
  Future<void> dispose() async {
    await streamController.close();
  }

  @override
  Stream<LiveEvent<T>> get eventsStream => streamController.stream;

  @override
  Future<void> subscribeToChannel(Id channelId) async {
    channelSubscriptions.add(channelId);
  }

  @override
  Future<void> connect() async {
    await client.connect();
  }

  @override
  Future<void> disconnect() async {
    await client.disconnect();
  }
}

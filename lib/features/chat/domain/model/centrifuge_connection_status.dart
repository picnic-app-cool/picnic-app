enum CentrifugeConnectionStatus {
  /// initial state before connecting or after user disconnected
  disconnected,

  /// client is connecting or reconnecting after
  connecting,

  /// client is connected and receives event from the channel
  connected,

  /// connection is completely closed and won't receive any new events, client should clear all resources
  closed,

  /// connection returns an error
  error
}

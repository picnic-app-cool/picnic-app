enum ChatEventType {
  /// contains a new message added to chat
  newMessageReceived('message.new'),

  /// contains update info about message reaction
  messageReactionUpdated('message.reacted'),

  /// whenever status of the connection to given chat changes
  connectionStatusChanged('connectionStatusChanged'),

  /// contains updated message
  messageUpdated('message.updated'),

  /// when message deleted from chat
  messageDeleted('message.deleted'),

  chatUpdated('chat.updated'),

  /// backend may introduce new events while the app doesn't support it
  unknown('unknown');

  final String value;

  const ChatEventType(this.value);

  static ChatEventType fromString(String value) => ChatEventType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatEventType.unknown,
      );
}

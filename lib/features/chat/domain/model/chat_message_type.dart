enum ChatMessageType {
  text('TEXT'),
  component('COMPONENT');

  final String stringVal;

  const ChatMessageType(this.stringVal);

  static ChatMessageType fromString(String value) => ChatMessageType.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatMessageType.text,
      );
}

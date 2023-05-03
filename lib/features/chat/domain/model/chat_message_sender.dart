enum ChatMessageSender {
  user('USER'),
  friend('FRIEND');

  final String value;

  const ChatMessageSender(this.value);

  static ChatMessageSender fromString(String value) => ChatMessageSender.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatMessageSender.user,
      );
}

enum ChatType {
  single('SINGLE'),
  circle('CIRCLE'),
  group('GROUP');

  final String value;

  const ChatType(this.value);

  static ChatType fromString(String value) => ChatType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatType.single,
      );

  String toJson() {
    return value;
  }
}

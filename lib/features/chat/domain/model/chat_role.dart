enum ChatRole {
  none('NONE'),
  member('MEMBER'),
  moderator('MODERATOR'),
  director('DIRECTOR');

  final String stringVal;

  const ChatRole(this.stringVal);

  static ChatRole fromString(String value) => ChatRole.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatRole.none,
      );
}

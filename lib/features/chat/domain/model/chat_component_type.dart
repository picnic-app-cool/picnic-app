enum ChatComponentType {
  circleInvite('CIRCLE_INVITE'),
  glitterBomb('GLITTER_BOMB'),
  unknown('');

  const ChatComponentType(this.stringVal);

  final String stringVal;

  static ChatComponentType fromString(String value) => ChatComponentType.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ChatComponentType.unknown,
      );
}

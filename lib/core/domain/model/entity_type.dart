enum EntityType {
  post('POST'),
  chat('CHAT'),
  comment('COMMENT');

  final String value;

  const EntityType(this.value);

  static EntityType fromString(String value) => EntityType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => EntityType.post,
      );
}

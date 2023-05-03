enum EmbedStatus {
  loading('LOADING'),
  success('SUCCESS'),
  error('ERROR');

  final String stringVal;

  const EmbedStatus(this.stringVal);

  static EmbedStatus fromString(String value) => EmbedStatus.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => EmbedStatus.error,
      );
}

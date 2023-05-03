enum ResolveStatus {
  resolved('RESOLVED'),
  unresolved('UNRESOLVED'),
  unknown('');

  const ResolveStatus(this.stringVal);

  final String stringVal;

  static ResolveStatus fromString(String value) => ResolveStatus.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ResolveStatus.unknown,
      );
}

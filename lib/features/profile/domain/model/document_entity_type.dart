enum DocumentEntityType {
  deleteAccount('delete_reasons_en'),
  unknown('');

  const DocumentEntityType(this.stringVal);

  final String stringVal;

  static DocumentEntityType fromString(String value) => DocumentEntityType.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => DocumentEntityType.unknown,
      );
}

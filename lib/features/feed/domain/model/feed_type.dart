enum FeedType {
  user('USER'),
  circle('CIRCLE'),
  slice('SLICE'),
  explore('EXPLORE'),
  custom('CUSTOM');

  final String value;

  const FeedType(this.value);

  static FeedType fromString(String value) => FeedType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => FeedType.custom,
      );
}

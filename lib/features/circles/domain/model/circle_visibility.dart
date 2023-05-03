enum CircleVisibility {
  opened(value: 'OPENED'),
  closed(value: 'CLOSED'),
  private(value: 'PRIVATE');

  final String value;

  const CircleVisibility({
    required this.value,
  });

  static List<CircleVisibility> get allTypes => [
        opened,
        closed,
        private,
      ];

  static CircleVisibility fromString(String value) => CircleVisibility.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleVisibility.opened,
      );

  String toJson() {
    return value;
  }
}

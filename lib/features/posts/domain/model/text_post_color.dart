enum TextPostColor {
  none('none'),
  blue('blue'),
  purple('purple'),
  yellow('yellow'),
  red('red'),
  green('green');

  final String value;

  const TextPostColor(this.value);

  static List<TextPostColor> get selectableValues => [...TextPostColor.values]..remove(TextPostColor.none);

  static TextPostColor fromString(String value) => TextPostColor.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => TextPostColor.none,
      );
}

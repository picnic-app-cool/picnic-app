import 'package:collection/collection.dart';

enum EnvironmentConfigSlug {
  staging('staging'),
  production('production');

  final String value;

  const EnvironmentConfigSlug(this.value);

  static EnvironmentConfigSlug? fromString(String? slug) {
    return EnvironmentConfigSlug.values.firstWhereOrNull(
      (element) => element.value.toLowerCase() == slug?.toLowerCase(),
    );
  }
}

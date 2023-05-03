abstract class ErrorFilter {
  /// Returns `true` if the error is satisfied by a condition filter
  bool suppress(dynamic error);
}

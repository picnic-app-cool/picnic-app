import 'package:template_utils/file_utils.dart';
import 'package:test/test.dart';

void main() {
  test("featureName", () {
    expect(
      "lib/features/identity/domain/repositories/auth_repository.dart".featureName,
      "identity",
    );
    expect(
      "lib/core/domain/repositories/auth_repository.dart".featureName,
      "",
    );
  });
}

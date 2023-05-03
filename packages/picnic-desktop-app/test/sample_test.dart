import 'package:flutter_test/flutter_test.dart';

import 'mocks/mocks.dart';

void main() {
  test(
    'sample test',
    () {
      expect(Mocks.appNavigator, isNotNull);
    },
  );
}

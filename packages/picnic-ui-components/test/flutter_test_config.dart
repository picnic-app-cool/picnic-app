import 'dart:async';

import 'test_utils/test_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await prepareAppForUnitTests();
  return testMain();
}

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/task_queue.dart';

void main() {
  test("functions should be executed sequentially", () {
    fakeAsync((async) {
      var firstCallExecuted = false;

      // without task_queue the futures are executed in parallel
      Future.wait([
        Future.delayed(const Duration(seconds: 1), () => firstCallExecuted = true),
        Future.sync(() => expect(firstCallExecuted, false)),
      ]);

      async.elapse(const Duration(seconds: 1));

      firstCallExecuted = false;

      // with task_queue the futures executed sequentially
      final queue = TaskQueue<void>();
      Future.wait([
        queue.run(() => Future.delayed(const Duration(seconds: 1), () => firstCallExecuted = true)),
        queue.run(() async => expect(firstCallExecuted, true)),
      ]);

      async.elapse(const Duration(seconds: 1));
    });
  });
}

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';

void main() {
  test(
    "onSessionInvalidated calls listeners",
    () async {
      final container = SessionInvalidatedListenersContainer();
      var counter = 0;
      container.registerOnSessionInvalidatedListener((_) => counter++);
      await container.onSessionInvalidated(tokenHashCode: 1);
      expect(counter, 1);
    },
  );
  test(
    "onSessionInvalidated don't call listeners twice when executed with the same tokenHashCode",
    () async {
      final container = SessionInvalidatedListenersContainer();
      var counter = 0;
      container.registerOnSessionInvalidatedListener((_) => counter++);
      await container.onSessionInvalidated(tokenHashCode: 1);
      await container.onSessionInvalidated(tokenHashCode: 1);
      expect(counter, 1);
    },
  );
  test(
    "onSessionInvalidated don't call listeners twice when executed with the same tokenHashCode in parallel",
    () {
      fakeAsync((async) {
        final container = SessionInvalidatedListenersContainer();
        const longWorkSimulationTime = Duration(milliseconds: 200);
        var counter = 0;

        container.registerOnSessionInvalidatedListener(
          (_) async => Future.delayed(longWorkSimulationTime, () => counter++),
        );

        container.onSessionInvalidated(tokenHashCode: 1);
        container.onSessionInvalidated(tokenHashCode: 1);
        async.elapse(longWorkSimulationTime * 2);
        expect(counter, 1);
      });
    },
  );
}

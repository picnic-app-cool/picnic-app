import 'dart:ui';

abstract class InAppEventPresentable {
  Future<void> onInit();

  Future<void> dispose();

  void onAppLifecycleStateChange(AppLifecycleState state);
}

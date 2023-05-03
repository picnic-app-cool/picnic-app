typedef PicnicToastHideCallback = Future<void> Function();

class PicnicToastController {
  PicnicToastController({
    required this.openTransitionDuration,
    required this.closeTransitionDuration,
  });

  final Duration openTransitionDuration;
  final Duration closeTransitionDuration;

  final List<PicnicToastHideCallback> _onHideCallbacks = [];

  void register({
    required PicnicToastHideCallback onHide,
  }) {
    _onHideCallbacks.add(onHide);
  }

  void unregister({
    required PicnicToastHideCallback onHide,
  }) {
    _onHideCallbacks.remove(onHide);
  }

  Future<void> hide() async {
    await Future.wait(_onHideCallbacks.map((e) => e()));
  }
}

// ignore_for_file: comment_references
import 'dart:math';

///Use this mixin in classes where you want to use random sleep.
///See [GraphqlChatRepository]
mixin FutureRetarder {
  static const _maxDurationMillis = 500;

  /// Convenience method to sleep randomly between 200 and [maxDurationMillis] to mimic network delays
  Future<void> randomSleep({int maxDurationMillis = _maxDurationMillis}) =>
      Future.delayed(_RandomDuration(maxDurationMillis: maxDurationMillis));
}

class _RandomDuration extends Duration {
  _RandomDuration({
    int minDurationMillis = _minDurationMillis,
    required int maxDurationMillis,
  }) : super(
          milliseconds:
              (Random().nextInt(maxDurationMillis) + minDurationMillis).clamp(minDurationMillis, maxDurationMillis),
        );
  static const _minDurationMillis = 200;
}

import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_screen_time_use_case.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';

class PostVisibilityTracker extends StatefulWidget {
  PostVisibilityTracker({
    required this.child,
    required this.postId,
  }) : super(key: ValueKey(postId));

  final Widget child;
  final Id postId;

  @override
  State<PostVisibilityTracker> createState() => _PostVisibilityTrackerState();
}

class _PostVisibilityTrackerState extends State<PostVisibilityTracker> {
  late Stopwatch _stopwatch;
  late LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  late SavePostScreenTimeUseCase _savePostScreenTimeUseCase;
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _logAnalyticsEventUseCase = getIt();
    _savePostScreenTimeUseCase = getIt();
    _userStore = getIt();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _viewDidDisappear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewInForegroundDetector(
      visibilityFraction: Constants.postVisibilityThreshold,
      viewDidAppear: _viewDidAppear,
      viewDidDisappear: _viewDidDisappear,
      child: widget.child,
    );
  }

  void _viewDidAppear() {
    _stopwatch
      ..reset()
      ..start();
  }

  void _viewDidDisappear() {
    if (!_stopwatch.isRunning) {
      return;
    }
    _stopwatch.stop();
    final duration = _stopwatch.elapsedMilliseconds;
    debugLog("post with id: ${widget.postId} seen for $duration ms.");
    _savePostScreenTimeUseCase.execute(
      postId: widget.postId,
      duration: duration,
    );
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.postViewingTime(
        postId: widget.postId,
        userId: _userStore.privateProfile.id,
        durationMilliseconds: duration,
      ),
    );
  }
}

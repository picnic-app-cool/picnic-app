import 'package:flutter/material.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/periodic_task_executor.dart';

class CountdownTimerBuilder extends StatefulWidget {
  const CountdownTimerBuilder({
    super.key,
    required this.currentTimeProvider,
    required this.deadline,
    required this.builder,
    this.period = const Duration(seconds: 1),
    this.timerCompleteBuilder,
  });

  final CurrentTimeProvider currentTimeProvider;
  final DateTime deadline;
  final Widget Function(BuildContext context, Duration) builder;
  final Duration period;
  final WidgetBuilder? timerCompleteBuilder;

  @override
  State<CountdownTimerBuilder> createState() => _CountdownTimerBuilderState();
}

class _CountdownTimerBuilderState extends State<CountdownTimerBuilder> {
  final periodicTaskExecutor = PeriodicTaskExecutor();

  Duration get timeRemaining {
    final remaining = widget.deadline.toUtc().difference(widget.currentTimeProvider.currentTime.toUtc());
    if (remaining.isNegative) {
      return Duration.zero;
    }
    return remaining;
  }

  bool get isCompleted => timeRemaining == Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return isCompleted && widget.timerCompleteBuilder != null //
        ? widget.timerCompleteBuilder!(context)
        : widget.builder(context, timeRemaining);
  }

  @override
  void dispose() {
    super.dispose();
    periodicTaskExecutor.cancel();
  }

  void _startTimer() {
    periodicTaskExecutor.start(
      period: widget.period,
      task: () => setState(() => doNothing()),
      shouldStop: () => isCompleted,
    );
  }
}

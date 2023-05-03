import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event_type.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method
class BroadcastLiveEvent<T> extends LiveEvent<T> {
  BroadcastLiveEvent({
    required this.event,
  });

  @override
  final T event;

  @override
  LiveEventType get type => LiveEventType.broadcast;
}

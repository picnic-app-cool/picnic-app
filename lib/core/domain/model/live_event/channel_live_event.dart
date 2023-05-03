import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method
class ChannelLiveEvent<T> extends LiveEvent<T> {
  ChannelLiveEvent({
    required this.event,
    required this.channelId,
  });

  @override
  final T event;
  final Id channelId;

  @override
  LiveEventType get type => LiveEventType.channel;
}

import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/centrifuge_connection_status.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';

class ConnectionStatusChangedEvent extends Equatable implements ChatEvent {
  const ConnectionStatusChangedEvent({
    required this.status,
  });

  const ConnectionStatusChangedEvent.empty() : status = CentrifugeConnectionStatus.disconnected;

  final CentrifugeConnectionStatus status;

  @override
  ChatEventType get type => ChatEventType.connectionStatusChanged;

  @override
  List<Object?> get props => [
        status,
      ];

  ConnectionStatusChangedEvent copyWith({
    CentrifugeConnectionStatus? status,
  }) {
    return ConnectionStatusChangedEvent(
      status: status ?? this.status,
    );
  }
}

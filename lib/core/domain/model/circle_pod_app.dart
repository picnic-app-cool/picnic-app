import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CirclePodApp extends Equatable {
  const CirclePodApp({
    required this.circleId,
    required this.app,
  });

  const CirclePodApp.empty()
      : circleId = const Id.empty(),
        app = const PodApp.empty();

  final Id circleId;
  final PodApp app;

  @override
  List<Object> get props => [
        circleId,
        app,
      ];

  CirclePodApp copyWith({
    Id? circleId,
    PodApp? app,
  }) {
    return CirclePodApp(
      circleId: circleId ?? this.circleId,
      app: app ?? this.app,
    );
  }
}

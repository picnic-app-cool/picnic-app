import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';

class CircleConfig extends Equatable {
  const CircleConfig({
    required this.type,
    required this.displayName,
    required this.emoji,
    required this.description,
    required this.enabled,
  });

  const CircleConfig.empty()
      : type = CircleConfigType.none,
        displayName = '',
        emoji = '',
        description = '',
        enabled = false;

  final CircleConfigType type;
  final String displayName;
  final String emoji;
  final String description;
  final bool enabled;

  @override
  List<Object?> get props => [
        type,
        displayName,
        emoji,
        description,
        enabled,
      ];

  CircleConfig copyWith({
    CircleConfigType? type,
    String? displayName,
    String? emoji,
    String? description,
    bool? enabled,
  }) {
    return CircleConfig(
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
      enabled: enabled ?? this.enabled,
    );
  }
}

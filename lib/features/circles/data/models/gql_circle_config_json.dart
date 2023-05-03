import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';

class GqlCircleConfigJson {
  const GqlCircleConfigJson({
    required this.type,
    required this.displayName,
    required this.emoji,
    required this.description,
    required this.enabled,
  });

  factory GqlCircleConfigJson.fromJson(Map<String, dynamic>? json) => GqlCircleConfigJson(
        type: asT<String>(json, 'name'),
        displayName: asT<String>(json, 'displayName'),
        description: asT<String>(json, 'description'),
        emoji: asT<String>(json, 'emoji'),
        enabled: asT<bool>(json, 'value'),
      );

  final String type;
  final String displayName;
  final String emoji;
  final String description;
  final bool enabled;

  CircleConfig toDomain() => CircleConfig(
        type: CircleConfigType.fromString(type),
        displayName: displayName,
        emoji: emoji,
        description: description,
        enabled: enabled,
      );
}

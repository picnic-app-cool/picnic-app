import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';

class GqlInterest {
  const GqlInterest({
    required this.id,
    required this.name,
    required this.emoji,
  });

  factory GqlInterest.fromJson(Map<String, dynamic>? json) => GqlInterest(
        id: asT<String>(json, 'id'),
        name: asT<String>(json, 'name'),
        emoji: asT<String>(json, 'emoji'),
      );

  final String id;
  final String name;
  final String emoji;

  Interest toDomain() => Interest(
        id: Id(id),
        name: normalizeString(name),
        emoji: emoji,
      );
}

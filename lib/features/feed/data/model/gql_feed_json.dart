import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';

class GqlFeedJson {
  const GqlFeedJson({
    required this.id,
    required this.type,
    required this.name,
    required this.circleJson,
  });

  factory GqlFeedJson.fromJson(Map<String, dynamic>? json) => GqlFeedJson(
        id: asT<String>(json, 'id'),
        type: asT<String>(json, 'type'),
        name: asT<String>(json, 'name'),
        circleJson: asT<Map<String, dynamic>>(json, 'circle'),
      );

  final String id;
  final String type;
  final String name;
  final Map<String, dynamic> circleJson;

  Feed toDomain() => Feed(
        id: Id(id),
        feedType: FeedType.fromString(type),
        name: normalizeString(name),
        circleId: Id(asT<String>(circleJson, 'id')),
        emoji: asT<String>(circleJson, 'image'),
        imageFile: asT<String>(circleJson, 'imageFile'),
        membersCount: asT<int>(
          circleJson,
          'membersCount',
          defaultValue: -1,
        ),
      );
}

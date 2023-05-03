import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlProfileNotificationData {
  const GqlProfileNotificationData({
    required this.id,
    required this.type,
    required this.name,
    required this.avatar,
    required this.relation,
  });

  factory GqlProfileNotificationData.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlProfileNotificationData(
      id: asT<String>(json, 'id'),
      type: asT<String>(json, 'type'),
      name: asT<String>(json, 'name'),
      avatar: asT<String>(json, 'avatar'),
      relation: asT<bool>(json, 'relation'),
    );
  }

  final String id;
  final String type;
  final String name;
  final String avatar;
  final bool relation;
}

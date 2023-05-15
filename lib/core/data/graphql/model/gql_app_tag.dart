import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAppTag {
  const GqlAppTag({
    required this.id,
    required this.name,
  });

  //ignore: long-method
  factory GqlAppTag.fromJson(Map<String, dynamic>? json) {
    return GqlAppTag(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
    );
  }

  final String id;
  final String name;

  AppTag toDomain() => AppTag(
        id: Id(id),
        name: name,
      );
}

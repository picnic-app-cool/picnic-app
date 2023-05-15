import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_permission.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAppPermission {
  const GqlAppPermission({
    required this.id,
    required this.dxName,
    required this.uxName,
    required this.description,
    required this.descriptors,
  });

  //ignore: long-method
  factory GqlAppPermission.fromJson(Map<String, dynamic>? json) {
    List<String>? descriptors;
    if (json != null && json['descriptors'] != null) {
      descriptors = (json['descriptors'] as List).map((e) => e.toString()).toList();
    }
    return GqlAppPermission(
      id: asT<String>(json, 'id'),
      dxName: asT<String>(json, 'dxName'),
      uxName: asT<String>(json, 'uxName'),
      description: asT<String>(json, 'description'),
      descriptors: descriptors ?? [],
    );
  }

  final String id;
  final String dxName;
  final String uxName;
  final String description;
  final List<String> descriptors;

  AppPermission toDomain() => AppPermission(
        id: Id(id),
        dxName: dxName,
        uxName: uxName,
        description: description,
        descriptors: descriptors,
      );
}

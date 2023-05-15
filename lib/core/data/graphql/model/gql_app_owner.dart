import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_owner.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAppOwner {
  const GqlAppOwner({
    required this.id,
    required this.name,
  });

  //ignore: long-method
  factory GqlAppOwner.fromJson(Map<String, dynamic>? json) {
    return GqlAppOwner(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
    );
  }

  final String id;
  final String name;

  AppOwner toDomain() => AppOwner(
        id: Id(id),
        name: name,
      );
}

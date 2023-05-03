import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/circles/domain/model/custom_role_meta.dart';

class GqlCustomRoleMeta {
  const GqlCustomRoleMeta({
    required this.configurable,
    required this.deletable,
    required this.assignable,
  });

  factory GqlCustomRoleMeta.fromJson(Map<String, dynamic>? json) {
    return GqlCustomRoleMeta(
      configurable: asT<bool>(json, 'configurable'),
      deletable: asT<bool>(json, 'deletable'),
      assignable: asT<bool>(json, 'assignable'),
    );
  }

  final bool configurable;
  final bool deletable;
  final bool assignable;

  CustomRoleMeta toDomain() => CustomRoleMeta(
        configurable: configurable,
        deletable: deletable,
        assignable: assignable,
      );
}

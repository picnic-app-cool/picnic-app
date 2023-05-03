//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlSuccessJson {
  const GqlSuccessJson({
    required this.success,
  });

  factory GqlSuccessJson.fromJson(Map<String, dynamic>? json) => GqlSuccessJson(
        success: asT<bool>(json, 'success'),
      );

  final bool success;
}

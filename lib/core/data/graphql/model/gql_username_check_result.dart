import 'package:picnic_app/core/domain/model/username_check_result.dart';

//ignore_for_file: unused-code, unused-files
class GqlUsernameCheckResult {
  GqlUsernameCheckResult({
    required this.available,
    required this.username,
  });

  factory GqlUsernameCheckResult.fromJson(Map<String, dynamic> json) => GqlUsernameCheckResult(
        available: json["available"] as bool? ?? false,
        username: json["username"] as String? ?? '',
      );

  final bool available;
  final String username;

  UsernameCheckResult toDomain() => UsernameCheckResult(
        username: username,
        isTaken: !available,
      );
}

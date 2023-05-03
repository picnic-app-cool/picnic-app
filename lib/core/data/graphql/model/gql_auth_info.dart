import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class GqlAuthInfo {
  const GqlAuthInfo({
    required this.accessToken,
    required this.refreshToken,
  });

  factory GqlAuthInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlAuthInfo(
      accessToken: asT<String>(json, 'accessToken'),
      refreshToken: asT<String>(json, 'refreshToken'),
    );
  }

  final String? accessToken;
  final String? refreshToken;

  AuthToken toDomain() => AuthToken(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
      );
}

import 'package:picnic_app/core/data/graphql/model/gql_auth_info.dart';
import 'package:picnic_app/core/data/graphql/model/gql_private_profile.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAuthResult {
  const GqlAuthResult({
    required this.authInfo,
    required this.user,
  });

  factory GqlAuthResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlAuthResult(
      authInfo: GqlAuthInfo.fromJson((json['authInfo'] as Map?)?.cast() ?? {}),
      user: GqlPrivateProfile.fromJson((json['user'] as Map?)?.cast() ?? {}),
    );
  }

  final GqlAuthInfo authInfo;
  final GqlPrivateProfile? user;

  AuthResult toDomain({
    required Id userId,
  }) =>
      AuthResult(
        userId: userId,
        authToken: authInfo.toDomain(),
        privateProfile: user?.toDomain() ?? const PrivateProfile.empty(),
      );
}

import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlGeneratedToken {
  const GqlGeneratedToken({
    required this.tokenID,
    required this.jwtToken,
  });

  //ignore: long-method
  factory GqlGeneratedToken.fromJson(Map<String, dynamic>? json) {
    return GqlGeneratedToken(
      tokenID: asT<String>(json, 'tokenID'),
      jwtToken: asT<String>(json, 'jwtToken'),
    );
  }

  final String tokenID;
  final String jwtToken;

  GeneratedToken toDomain() => GeneratedToken(
        tokenID: Id(tokenID),
        jwtToken: jwtToken,
      );
}

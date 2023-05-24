import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GeneratedToken extends Equatable {
  const GeneratedToken({
    required this.tokenID,
    required this.jwtToken,
  });

  const GeneratedToken.empty()
      : tokenID = const Id.empty(),
        jwtToken = '';

  final Id tokenID;
  final String jwtToken;

  @override
  List<Object> get props => [
        tokenID,
        jwtToken,
      ];

  GeneratedToken copyWith({
    Id? tokenID,
    String? jwtToken,
  }) {
    return GeneratedToken(
      tokenID: tokenID ?? this.tokenID,
      jwtToken: jwtToken ?? this.jwtToken,
    );
  }
}

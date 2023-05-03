class GqlFirebaseAuthInput {
  GqlFirebaseAuthInput({
    required this.thirdPartyUserid,
    required this.accessToken,
  });

  final String thirdPartyUserid;
  final String accessToken;

  Map<String, dynamic> toJson() {
    return {
      'thirdPartyUserid': thirdPartyUserid,
      'accessToken': accessToken,
    };
  }
}

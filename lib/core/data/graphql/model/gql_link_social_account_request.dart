import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';

extension GqlLinkSocialAccountRequest on LinkSocialAccountRequest {
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'redirectUri': redirectUri,
    };
  }
}

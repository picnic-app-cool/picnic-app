import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';

const String checkUsernameQuery = """
query(\$username: String!) {
  checkUsername(username: \$username) {
      username,
      available
  }
}
""";

String signInWithFirebaseMutation({required bool includeDebugOption}) => """
mutation signInWithFirebase(\$credentials: FirebaseAuthInput!) {
    signInWithFirebase(
        credentials: \$credentials,
        ${includeDebugOption ? _debugOption : ""}
    ) {
        user {
            ${GqlTemplate().fullUser}
        }
        authInfo {
            accessToken
            refreshToken
        }
    }
}
""";

String signUpWithFirebaseMutation({required bool includeDebugOption}) => """
mutation signUpWithFirebase(\$credentials: FirebaseAuthInput!, \$userInfo: UserSignUpInput!) {
    signUpWithFirebase(
        credentials: \$credentials,
        userInfo: \$userInfo,
        ${includeDebugOption ? _debugOption : ""}
    ) {
        user {
            ${GqlTemplate().fullUser}
        }
        authInfo {
            accessToken
            refreshToken
        }
    }
}
""";

String refreshTokenMutation({required bool includeDebugOption}) => """
mutation refreshTokens(\$accessToken: String!, \$refreshToken: String!) {
    refreshTokens(
        accessToken: \$accessToken,
        refreshToken: \$refreshToken,
        ${includeDebugOption ? _debugOption : ""}
    ) {
        user{
            ${GqlTemplate().fullUser}
        },
        authInfo {
            accessToken
            refreshToken
        }
    }
}
""";

const String getSignInCaptchaParamsQuery = """
query() {
  getSignInCaptchaParams() {
    recaptchaSiteKey
  }
}
""";

String checkVerificationCodeQuery = """
mutation checkVerificationCode(\$code: String!, \$sessionInfo: String!) {
  checkVerificationCode(code: \$code, sessionInfo: \$sessionInfo) {
    user { 
      ${GqlTemplate().fullUser}
    }
    authInfo {
      accessToken
    }
  }
}
""";

String signInWithUsernameMutation = """
mutation signInWithUsername(\$username: String!, \$recaptchaToken: String!) {
  signInWithUsername(username: \$username, recaptchaToken: \$recaptchaToken) {
      signInMethod,
      maskedIdentifier,
      sessionInfo
  }
}
""";

String signInWithDiscordMutation = """
    mutation signInWithDiscord(\$credentials: DiscordTokenInput!) {
      signInWithDiscord(credentials: \$credentials) {
        user {
          ${GqlTemplate().fullUser}
        }
        authInfo {
          accessToken
          refreshToken
        }
      }
    }
""";

///used in auth/refresh token mutations to generate short-lived access/refresh tokens for debug purposes
///
/// IMPORTANT: don't use ttl values below 20 seconds, as it turns out it breaks backend 🤡
String get _debugOption => """
debugOption: {
            accessTokenTtlSeconds: ${Constants.shortLivedTokenTTLSeconds},
            refreshTokenTtlSeconds: 60
}
""";

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:picnic_app/core/data/firebase/actions/firebase_actions_factory.dart';
import 'package:picnic_app/core/data/graphql/auth_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_result.dart';
import 'package:picnic_app/core/data/graphql/model/gql_firebase_auth_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_sign_in_captcha_params.dart';
import 'package:picnic_app/core/data/graphql/model/gql_sign_in_with_username_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user_sign_up_input.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/discord_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/username_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_captcha_params_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/sign_in_with_username_failure.dart';

class FirebaseGraphqlAuthRepository implements AuthRepository {
  FirebaseGraphqlAuthRepository(
    this._gqlClient,
    this._actionsFactory,
    this._configProvider,
  );

  static const userNotFoundErrorCode = 'NotFound';

  final GraphQLClient _gqlClient;
  final FirebaseActionsFactory _actionsFactory;
  final EnvironmentConfigProvider _configProvider;

  /// used for forcing resending code trough sms
  static int? _forceResendingCodeToken;

  /// Stores firebase auth result to be used during `register`.
  /// For registration flow, signing in with firebase and registering in our backend are two separate actions
  late UserCredential _firebaseResult;

  @override
  Future<Either<RequestPhoneCodeFailure, PhoneVerificationData>> requestPhoneCode({
    required PhoneVerificationData verificationData,
  }) async =>
      _actionsFactory.requestPhoneCodeAction
          .requestPhoneCode(
            forceResendingCodeToken: _forceResendingCodeToken,
            verificationData: verificationData,

            ///saving the token for potential reuse when calling resend, this is firebase-specific
            /// thus not propagating it outside of this repository
            onForceResendingTokenReceived: (token) => _forceResendingCodeToken = token,
          ) //
          .doOn(
            fail: (fail) => logError(fail),
          );

  @override
  Future<Either<LogInFailure, AuthResult>> logIn({
    required LogInCredentials credentials,
  }) async {
    if (credentials is UsernameLogInCredentials) {
      return _usernameLogIn(
        code: credentials.verificationData.code,
        sessionInfo: credentials.verificationData.signInWithUsernamePayload.sessionInfo,
      );
    }

    if (credentials is DiscordLogInCredentials) {
      return _discordLogIn(
        code: credentials.code,
      );
    }

    return _firebaseLogIn(credentials: credentials);
  }

  @override
  Future<Either<RegisterFailure, AuthResult>> register({
    required OnboardingFormData formData,
  }) async {
    return _gqlClient
        .mutate(
      document: signUpWithFirebaseMutation(
        includeDebugOption: await _configProvider.shouldUseShortLivedAuthTokens(),
      ),
      variables: {
        'credentials': (await _firebaseResult.toFirebaseAuthInput()).toJson(),
        'userInfo': formData.toUserSignUpInput().toJson(),
      },
      parseData: (json) {
        return GqlAuthResult.fromJson((json['signUpWithFirebase'] as Map).cast());
      },
    )
        .mapFailure((fail) {
      return const RegisterFailure.unknown();
    }).mapSuccess((signInResult) {
      return _firebaseResult.toAuthResult(signInResult: signInResult);
    });
  }

  @override
  Future<Either<GetCaptchaParamsFailure, SignInCaptchaParams>> getCaptchaParams() => _gqlClient
      .query(
        document: getSignInCaptchaParamsQuery,
        parseData: (json) => GqlSignInCaptchaParams.fromJson(json).toDomain(),
      )
      .mapFailure(GetCaptchaParamsFailure.unknown);

  @override
  Future<Either<SignInWithUsernameFailure, SignInWithUsernamePayload>> signInWithUsername({
    required String username,
    required String recaptchaToken,
  }) async =>
      _gqlClient
          .mutate(
            document: signInWithUsernameMutation,
            variables: {
              'username': username,
              'recaptchaToken': recaptchaToken,
            },
            parseData: (json) => GqlSignInWithUsernamePayload.fromJson(json).toDomain(),
          )
          .mapFailure(SignInWithUsernameFailure.unknown);

  Future<Either<LogInFailure, AuthResult>> _usernameLogIn({
    required String code,
    required String sessionInfo,
  }) async =>
      _gqlClient
          .mutate(
            document: checkVerificationCodeQuery,
            variables: {
              'code': code,
              'sessionInfo': sessionInfo,
            },
            parseData: (json) {
              final innerJson = asT<Map<String, dynamic>>(json, "checkVerificationCode");
              final authResult = GqlAuthResult.fromJson(innerJson);
              return authResult.toDomain(userId: authResult.user!.toDomain().id);
            },
          )
          .mapFailure(LogInFailure.unknown);

  Future<Either<LogInFailure, AuthResult>> _discordLogIn({
    required String code,
  }) async {
    return _gqlClient
        .mutate(
          document: signInWithDiscordMutation,
          variables: {
            'credentials': {'code': code},
          },
          parseData: (json) {
            final authResult = GqlAuthResult.fromJson((json['signInWithDiscord'] as Map).cast());
            return authResult.toDomain(userId: authResult.user!.toDomain().id);
          },
        )
        .mapFailure(LogInFailure.unknown);
  }

  Future<Either<LogInFailure, AuthResult>> _firebaseLogIn({
    required LogInCredentials credentials,
  }) =>
      _firebaseAuth(credentials)
          .doOn(success: (res) => _firebaseResult = res) //
          .flatMap(
            (firebaseResult) async => _gqlClient
                .mutate(
              document: signInWithFirebaseMutation(
                includeDebugOption: await _configProvider.shouldUseShortLivedAuthTokens(),
              ),
              variables: {
                'credentials': await firebaseResult.toFirebaseAuthInput(),
              },
              parseData: (json) => GqlAuthResult.fromJson((json['signInWithFirebase'] as Map).cast()),
            )
                .mapFailure((fail) {
              if (fail.errorCode == userNotFoundErrorCode) {
                return LogInFailure.userNotFound(fail, Id(_firebaseResult.user?.uid ?? ''));
              }
              return LogInFailure.unknown(fail);
            }).mapSuccess((signInResult) => firebaseResult.toAuthResult(signInResult: signInResult)),
          );

  Future<Either<LogInFailure, UserCredential>> _firebaseAuth(LogInCredentials credentials) {
    Future<Either<LogInFailure, UserCredential>> firebaseResult;
    switch (credentials.type) {
      case LogInType.google:
        firebaseResult = _actionsFactory.logInWithGoogleAction.signIn(credentials);
        break;
      case LogInType.apple:
        firebaseResult = _actionsFactory.logInWithAppleAction.signIn(credentials);
        break;
      case LogInType.phone:
        firebaseResult = _actionsFactory.logInWithPhoneAction.signIn(credentials: credentials);
        break;
      default:
        throw const LogInFailure.unknown("Firebase auth doesn't support username authentication");
    }
    return firebaseResult;
  }
}

extension FirebaseAuthResult on UserCredential {
  AuthResult toAuthResult({
    required GqlAuthResult signInResult,
  }) {
    final userId = Id(user?.uid ?? '');
    return signInResult.toDomain(
      userId: userId,
    );
  }
}

extension FirebaseAuthInputMapper on UserCredential {
  Future<GqlFirebaseAuthInput> toFirebaseAuthInput() async => GqlFirebaseAuthInput(
        thirdPartyUserid: user?.uid ?? '',
        accessToken: await (user?.getIdToken() ?? Future.value('')),
      );
}

extension UserSignUpInputMapper on OnboardingFormData {
  GqlUserSignUpInput toUserSignUpInput() => GqlUserSignUpInput(
        username: username,
        age: int.tryParse(age) ?? 0,
        countryCode: country,
        languageCodes: [language.code],
        notificationsEnabled: notificationsStatus == RuntimePermissionStatus.granted,
        email: '',
        phone: phoneVerificationData.phoneNumber,
        profileImage: profilePhotoPath,
      );
}

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/firebase_graphql_auth_repository.dart';
import 'package:picnic_app/core/data/graphql/auth_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_info.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_result.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  const firebaseUserId = 'firebase-user-id';
  late FirebaseGraphqlAuthRepository repository;

  Future<Either<GraphQLFailure, GqlAuthResult>> signInMutateStubber() => Mocks.graphQlClient.mutate(
        document: signInWithFirebaseMutation(includeDebugOption: false),
        parseData: any(named: "parseData"),
        variables: any(named: "variables"),
      );

  Future<Either<LogInFailure, UserCredential>> phoneSignInStubber() => Mocks.logInWithPhoneAction.signIn(
        credentials: any(named: "credentials"),
      );

  setUp(
    () {
      repository = FirebaseGraphqlAuthRepository(
        Mocks.graphQlClient,
        Mocks.firebaseActionsFactory,
        Mocks.environmentConfigProvider,
      );
      when(() => Mocks.environmentConfigProvider.shouldUseShortLivedAuthTokens()).thenAnswer((_) async => false);
      when(() => Mocks.firebaseActionsFactory.logInWithPhoneAction).thenReturn(Mocks.logInWithPhoneAction);
      when(() => phoneSignInStubber()).thenAnswer((invocation) {
        return successFuture(Mocks.userCredential);
      });
      when(() => Mocks.userCredential.user).thenReturn(Mocks.firebaseUser);
      when(() => Mocks.firebaseUser.uid).thenReturn(firebaseUserId);
      when(() => Mocks.firebaseUser.getIdToken()).thenAnswer((_) async => 'id token');
    },
  );

  test(
    "signIn should return 'userNotFound' error based on graphql response",
    () async {
      when(() => signInMutateStubber()).thenFailure(
        (_) => GraphQLFailure.unknown(
          OperationException(
            graphqlErrors: [
              const GraphQLError(
                message: 'rpc error: code = NotFound desc = account not found',
                path: ['signInWithFirebase'],
              )
            ],
          ),
        ),
      );
      final result = await repository.logIn(credentials: const PhoneLogInCredentials.empty());
      expect(result.getFailure()!.type, LogInFailureType.userNotFound);

      ///this is needed so that registration flow validates the data and can continue without errors
      expect(result.getFailure()!.userId!.value, firebaseUserId);
      expect(result.getFailure()!.toAuthResult().userId.value, firebaseUserId);
    },
  );

  test(
    "signIn should return 'unknown' error if it can't determine it from response",
    () async {
      when(() => signInMutateStubber()).thenFailure(
        (_) => GraphQLFailure.unknown(
          OperationException(
            graphqlErrors: [
              const GraphQLError(
                message: '',
                path: ['signInWithFirebase'],
              )
            ],
          ),
        ),
      );
      final result = await repository.logIn(credentials: const PhoneLogInCredentials.empty());
      expect(result.getFailure()!.type, LogInFailureType.unknown);
    },
  );

  test(
    "signIn should have correct flow",
    () async {
      when(() => signInMutateStubber()).thenAnswer(
        (invocation) => successFuture(
          const GqlAuthResult(
            authInfo: GqlAuthInfo(accessToken: "accessToken", refreshToken: 'refreshToken'),
            user: null,
          ),
        ),
      );
      final result = await repository.logIn(credentials: const PhoneLogInCredentials.empty());
      verifyInOrder([
        () => phoneSignInStubber(),
        () => signInMutateStubber(),
      ]);
      expect(result.isSuccess, true);
    },
  );
}

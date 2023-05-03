import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetAuthTokenUseCase useCase;

  setUp(() {
    useCase = GetAuthTokenUseCase(
      Mocks.authTokenRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.authTokenRepository.getAuthToken()).thenSuccess(
        (invocation) => Stubs.authToken,
      );

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess()!.accessToken, Stubs.authToken.accessToken);
      expect(result.getSuccess()!.refreshToken, Stubs.authToken.refreshToken);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetAuthTokenUseCase>();
    expect(useCase, isNotNull);
  });
}

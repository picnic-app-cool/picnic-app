import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late SaveAuthTokenUseCase useCase;

  setUp(() {
    useCase = SaveAuthTokenUseCase(
      Mocks.authTokenRepository,
    );

    when(() => Mocks.authTokenRepository.saveAuthToken(any())).thenSuccess((invocation) => unit);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(authToken: Stubs.authToken);
      verify(
        () => Mocks.authTokenRepository.saveAuthToken(Stubs.authToken),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SaveAuthTokenUseCase>();
    expect(useCase, isNotNull);
  });
}

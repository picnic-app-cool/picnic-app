import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/domain/use_cases/invalidate_token_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late InvalidateTokenUseCase useCase;

  setUp(() {
    useCase = InvalidateTokenUseCase(
      Mocks.authTokenRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.authTokenRepository.getAuthToken()).thenSuccess((_) => Stubs.authToken);
      when(() => Mocks.authTokenRepository.saveAuthToken(any())).thenSuccess((_) => unit);

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      verify(
        () => Mocks.authTokenRepository.saveAuthToken(any()),
      );
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<InvalidateTokenUseCase>();
    expect(useCase, isNotNull);
  });
}

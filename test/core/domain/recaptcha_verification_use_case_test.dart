import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/recaptcha_verification_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late RecaptchaVerificationUseCase useCase;

  setUp(() {
    when(() => Mocks.recaptchaRepository.getRecaptchaVerificationTokenViaWebview(any())).thenAnswer(
      (invocation) => successFuture(""),
    );
    useCase = RecaptchaVerificationUseCase(
      Mocks.recaptchaRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      const siteKey = "testSiteKey";

      // WHEN
      final result = await useCase.execute(siteKey: siteKey);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RecaptchaVerificationUseCase>();
    expect(useCase, isNotNull);
  });
}

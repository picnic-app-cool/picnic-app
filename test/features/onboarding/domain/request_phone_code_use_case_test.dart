import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late RequestPhoneCodeUseCase useCase;

  setUp(() {
    useCase = RequestPhoneCodeUseCase(
      Mocks.authRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.authRepository.requestPhoneCode(verificationData: any(named: "verificationData"))).thenAnswer(
        (invocation) => successFuture(
          (invocation.namedArguments[#verificationData] as PhoneVerificationData).copyWith(
            verificationId: "someVerificationId",
          ),
        ),
      );
      // WHEN
      final result = await useCase.execute(
        verificationData: const PhoneVerificationData.empty().copyWith(phoneNumber: '+48731212123'),
      );

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess()!.verificationId, isNotEmpty);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RequestPhoneCodeUseCase>();
    expect(useCase, isNotNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late GetPrivateProfileUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();
      verify(() => Mocks.privateProfileRepository.getPrivateProfile());
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPrivateProfileUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetPrivateProfileUseCase(Mocks.privateProfileRepository);

    when(() => Mocks.privateProfileRepository.getPrivateProfile()) //
        .thenAnswer((_) => successFuture(Stubs.privateProfile));

    when(() => ProfileMocks.getPrivateProfileUseCase.execute()).thenAnswer((_) => successFuture(Stubs.privateProfile));
  });
}

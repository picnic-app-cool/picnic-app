import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/domain/use_cases/check_username_availability_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late CheckUsernameAvailabilityUseCase useCase;

  setUp(() {
    useCase = CheckUsernameAvailabilityUseCase(Mocks.usersRepository);
  });

  test(
    'should report "andrzejc" as taken',
    () async {
      // GIVEN
      when(() => Mocks.usersRepository.checkUsernameAvailability(username: 'andrzejc')).thenAnswer(
        (_) => successFuture(
          const UsernameCheckResult(
            username: 'andrzejc',
            isTaken: true,
          ),
        ),
      );

      // WHEN
      final result = await useCase.execute(username: 'andrzejc');

      // THEN
      expect(result.getSuccess()?.isTaken, true);
    },
  );

  test(
    'should report "andrzejchm" as free',
    () async {
      // GIVEN
      when(() => Mocks.usersRepository.checkUsernameAvailability(username: 'andrzejchm')).thenAnswer(
        (_) => successFuture(
          const UsernameCheckResult(
            username: 'andrzejchm',
            isTaken: false,
          ),
        ),
      );

      // WHEN
      final result = await useCase.execute(username: 'andrzejchm');

      // THEN
      expect(result.getSuccess()?.isTaken, false);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CheckUsernameAvailabilityUseCase>();
    expect(useCase, isNotNull);
  });
}

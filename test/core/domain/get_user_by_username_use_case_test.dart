import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_by_username_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetUserByUsernameUseCase useCase;

  setUp(() {
    useCase = GetUserByUsernameUseCase(Mocks.usersRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.usersRepository.getUserId(username: any(named: 'username')),
      ).thenAnswer((_) => successFuture(const Id("userId")));

      // WHEN
      final result = await useCase.execute(username: 'username');

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserByUsernameUseCase>();
    expect(useCase, isNotNull);
  });
}

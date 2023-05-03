import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UnblockUserUseCase useCase;
  final user = const User.empty().copyWith(id: const Id("userId"));

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(userId: user.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnblockUserUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UnblockUserUseCase(Mocks.usersRepository);

    when(
      () => Mocks.usersRepository.unblock(
        userId: user.id,
      ),
    ).thenAnswer((invocation) => successFuture(unit));
  });
}

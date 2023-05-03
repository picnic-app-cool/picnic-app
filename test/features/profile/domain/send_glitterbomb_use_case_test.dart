import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late SendGlitterBombUseCase useCase;

  setUp(() {
    useCase = SendGlitterBombUseCase(Mocks.usersRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.usersRepository.sendGlitterBomb(userId: const Id.empty()))
          .thenAnswer((invocation) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(const Id.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SendGlitterBombUseCase>();
    expect(useCase, isNotNull);
  });
}

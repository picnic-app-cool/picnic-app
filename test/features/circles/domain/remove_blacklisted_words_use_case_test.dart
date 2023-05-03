import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/remove_blacklisted_words_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late RemoveBlacklistedWordsUseCase useCase;

  setUp(() {
    useCase = RemoveBlacklistedWordsUseCase(CirclesMocks.circleModeratorActionsRepository);

    when(
      () => CirclesMocks.circleModeratorActionsRepository.removeBlacklistedWords(
        circleId: any(named: 'circleId'),
        words: any(named: 'words'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.id,
        words: ['fork'],
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RemoveBlacklistedWordsUseCase>();
    expect(useCase, isNotNull);
  });
}

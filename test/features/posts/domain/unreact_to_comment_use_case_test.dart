import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_comment_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late UnreactToCommentUseCase useCase;

  setUp(() {
    useCase = UnreactToCommentUseCase(
      PostsMocks.commentsRepository,
      Mocks.hapticFeedbackUseCase,
    );
    when(
      () => Mocks.hapticFeedbackUseCase.execute(),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => PostsMocks.commentsRepository.unReactToComment(
          commentId: const Id.empty(),
        ),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(
        const Id.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.hapticFeedbackUseCase.execute());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnreactToCommentUseCase>();
    expect(useCase, isNotNull);
  });
}

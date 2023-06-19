import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_unlike_comment_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late LikeUnlikeCommentUseCase useCase;

  setUp(() {
    useCase = LikeUnlikeCommentUseCase(
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
    'use case executes normally with like',
    () async {
      // GIVEN
      when(
        () => PostsMocks.commentsRepository.likeDislikeComment(
          commentId: const Id.empty(),
          likeDislikeReaction: LikeDislikeReaction.like,
        ),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(
        commentId: const Id.empty(),
        likeDislikeReaction: LikeDislikeReaction.like,
      );

      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.hapticFeedbackUseCase.execute());
    },
  );

  test(
    'use case executes normally with dislike',
    () async {
      // GIVEN
      when(
        () => PostsMocks.commentsRepository.likeDislikeComment(
          commentId: const Id.empty(),
          likeDislikeReaction: LikeDislikeReaction.dislike,
        ),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(
        commentId: const Id.empty(),
        likeDislikeReaction: LikeDislikeReaction.dislike,
      );

      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.hapticFeedbackUseCase.execute());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LikeUnlikeCommentUseCase>();
    expect(useCase, isNotNull);
  });
}

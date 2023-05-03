import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_unlike_post_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late LikeUnlikePostUseCase useCase;

  setUp(() {
    useCase = LikeUnlikePostUseCase(
      PostsMocks.postsRepository,
      Mocks.hapticFeedbackUseCase,
    );
    when(
      () => PostsMocks.postsRepository.likeUnlikePost(
        id: Stubs.imagePost.id,
        like: true,
      ),
    ).thenAnswer((_) => successFuture(true));
    when(
      () => PostsMocks.postsRepository.getPostById(
        id: Stubs.imagePost.id,
      ),
    ).thenAnswer((_) => successFuture(Stubs.imagePost));
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

      // WHEN
      final result = await useCase.execute(
        id: Stubs.imagePost.id,
        like: true,
      );

      // TODO: Update this test when the repository is implemented and the use case returns true
      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.hapticFeedbackUseCase.execute());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LikeUnlikePostUseCase>();
    expect(useCase, isNotNull);
  });
}

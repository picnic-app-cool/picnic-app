import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetPostUseCase useCase;

  setUp(() {
    useCase = GetPostUseCase(PostsMocks.postsRepository);

    when(
      () => PostsMocks.postsRepository.getPostById(id: Stubs.posts.items.first.id),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.posts.items.first),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(postId: Stubs.posts.items.first.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPostUseCase>();
    expect(useCase, isNotNull);
  });
}

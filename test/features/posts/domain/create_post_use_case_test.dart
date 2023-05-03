import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late CreatePostUseCase useCase;

  setUp(() {
    useCase = CreatePostUseCase(PostsMocks.postsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => PostsMocks.postsRepository.createPostInBackground(createPostInput: Stubs.createTextPostInput))
          .thenAnswer((_) => successFuture(unit));

      // WHEN
      await useCase.execute(createPostInput: Stubs.createTextPostInput);

      // THEN
      verify(() => PostsMocks.postsRepository.createPostInBackground(createPostInput: Stubs.createTextPostInput))
          .called(1);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreatePostUseCase>();
    expect(useCase, isNotNull);
  });
}

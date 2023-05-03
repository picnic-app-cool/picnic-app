import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../features/posts/mocks/posts_mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late DeletePostsUseCase useCase;

  setUp(() {
    useCase = DeletePostsUseCase(PostsMocks.postsRepository);

    when(() {
      return PostsMocks.postsRepository.deletePosts(postIds: [Stubs.id]);
    }).thenAnswer((_) => successFuture(unit));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(postIds: [Stubs.id]);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<DeletePostsUseCase>();
    expect(useCase, isNotNull);
  });
}

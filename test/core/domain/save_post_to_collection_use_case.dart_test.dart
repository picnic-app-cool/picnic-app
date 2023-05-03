import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';

import '../../features/posts/mocks/posts_mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SavePostToCollectionUseCase useCase;

  setUp(() {
    useCase = SavePostToCollectionUseCase(PostsMocks.postsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN

      when(
        () => PostsMocks.postsRepository.updatePostCollectionStatus(
          input: const SavePostInput.empty(),
        ),
      ).thenAnswer(
        (_) => successFuture(true),
      );

      when(
        () => PostsMocks.postsRepository.getPostById(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) => successFuture(Stubs.imagePost),
      );
      final result = await useCase.execute(
        input: const SavePostInput.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SavePostToCollectionUseCase>();
    expect(useCase, isNotNull);
  });
}

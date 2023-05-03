import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetCommentsPreviewUseCase useCase;

  setUp(() {
    useCase = GetCommentsPreviewUseCase(PostsMocks.commentsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => PostsMocks.commentsRepository.getCommentsPreview(
          postId: any(named: 'postId'),
          count: any(
            named: 'count',
          ),
        ),
      ).thenAnswer((_) => successFuture(const []));

      // WHEN
      final result = await useCase.execute(
        postId: const Id.none(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCommentsPreviewUseCase>();
    expect(useCase, isNotNull);
  });
}

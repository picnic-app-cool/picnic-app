import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unpin_comment_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

//create test for UnpinCommentUseCase
void main() {
  late UnpinCommentUseCase useCase;

  setUp(() {
    useCase = UnpinCommentUseCase(PostsMocks.commentsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => PostsMocks.commentsRepository.unpinComment(commentId: any(named: 'commentId')))
          .thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(commentId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnpinCommentUseCase>();
    expect(useCase, isNotNull);
  });
}

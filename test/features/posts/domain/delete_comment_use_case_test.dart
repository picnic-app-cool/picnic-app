import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/delete_comment_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late DeleteCommentUseCase useCase;

  setUp(() {
    useCase = DeleteCommentUseCase(PostsMocks.commentsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => PostsMocks.commentsRepository.deleteComment(commentId: any(named: 'commentId')))
          .thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(commentId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<DeleteCommentUseCase>();
    expect(useCase, isNotNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_comment_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late CreateCommentUseCase useCase;

  setUp(() {
    useCase = CreateCommentUseCase(PostsMocks.commentsRepository);
    when(
      () => PostsMocks.commentsRepository.createComment(
        postId: any(named: 'postId'),
        parentCommentId: any(named: 'parentCommentId'),
        text: any(named: 'text'),
        postAuthorId: any(named: 'postAuthorId'),
      ),
    ).thenAnswer((_) => successFuture(Stubs.comments));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        postId: const Id.empty(),
        text: 'test',
        postAuthorId: const Id.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateCommentUseCase>();
    expect(useCase, isNotNull);
  });
}

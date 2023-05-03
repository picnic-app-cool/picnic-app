import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetCommentsUseCase useCase;

  setUp(() {
    useCase = GetCommentsUseCase(PostsMocks.commentsRepository);
    when(
      () => PostsMocks.commentsRepository.getComments(
        post: const Post.empty(),
        parentCommentId: const Id.none(),
        cursor: any(named: 'cursor'),
      ),
    ).thenAnswer((_) => successFuture(Stubs.comments));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN

      final result = await useCase.execute(
        post: const Post.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess(), Stubs.comments);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCommentsUseCase>();
    expect(useCase, isNotNull);
  });
}

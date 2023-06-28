import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/use_cases/vote_in_poll_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late VoteInPollUseCase useCase;

  setUp(() {
    useCase = VoteInPollUseCase(
      PostsMocks.postsRepository,
      PostsMocks.getPostUseCase,
    );
    when(
      () => PostsMocks.postsRepository.voteInPoll(
        voteInPollInput: const VoteInPollInput.empty(),
      ),
    ).thenAnswer((_) => successFuture(const Id.empty()));

    when(
      () => PostsMocks.getPostUseCase.execute(postId: const Id.empty()),
    ).thenAnswer((_) => successFuture(Stubs.pollPost));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(const VoteInPollInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<VoteInPollUseCase>();
    expect(useCase, isNotNull);
  });
}

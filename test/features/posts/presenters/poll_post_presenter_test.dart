import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presenter.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late PollPostPresentationModel model;
  late PollPostPresenter presenter;
  late MockPostPollNavigator navigator;

  test(
    'should vote for left poll post answer',
    () {
      // GIVEN
      final votesBefore = presenter.state.pollContent.leftPollAnswer.votesCount;

      // WHEN
      presenter.onVoted(PicnicPollVote.left);

      // THEN
      expect(presenter.state.pollContent.leftPollAnswer.votesCount, votesBefore + 1);
    },
  );

  test(
    'should vote for right poll post answer',
    () {
      // GIVEN
      final votesBefore = presenter.state.pollContent.rightPollAnswer.votesCount;

      // WHEN
      presenter.onVoted(PicnicPollVote.right);

      // THEN
      expect(presenter.state.pollContent.rightPollAnswer.votesCount, votesBefore + 1);
    },
  );

  setUp(() {
    when(() => PostsMocks.voteInPollUseCase.execute(any())).thenAnswer(
      (_) => successFuture(Stubs.pollPost),
    );
    model = PollPostPresentationModel.initial(
      PollPostInitialParams(
        reportId: Stubs.id,
        post: Stubs.pollPost,
        onPostUpdated: (_) {},
      ),
    );
    navigator = MockPostPollNavigator();
    when(() => navigator.showFxEffect(any())).thenAnswer((_) => Future.value());
    presenter = PollPostPresenter(
      model,
      navigator,
      PostsMocks.voteInPollUseCase,
      Mocks.userStore,
    );
  });
}

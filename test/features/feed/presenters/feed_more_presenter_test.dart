import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presenter.dart';

import '../mocks/feed_mock_definitions.dart';
import '../mocks/feed_mocks.dart';

void main() {
  late FeedMorePresentationModel model;
  late FeedMorePresenter presenter;
  late MockFeedMoreNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = FeedMorePresentationModel.initial(const FeedMoreInitialParams(initialFeedsPageId: Id.none()));
    navigator = MockFeedMoreNavigator();
    presenter = FeedMorePresenter(
      model,
      navigator,
      FeedMocks.getFeedsListUseCase,
      FeedMocks.localFeedsStore,
    );
  });
}

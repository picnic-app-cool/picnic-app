import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late PostSharePresentationModel model;
  late PostSharePresenter presenter;
  late MockPostShareNavigator navigator;

  test(
    'should call share route on tap share',
    () async {
      when(() => navigator.shareText(text: any(named: 'text'))).thenAnswer(
        (invocation) => Future.value(),
      );
      await presenter.onTapShare();
      verify(() => navigator.shareText(text: any(named: 'text')));
    },
  );

  test(
    'should call report form route on tap report',
    () async {
      when(() => navigator.openReportForm(any())).thenAnswer(
        (invocation) => Future.value(),
      );
      await presenter.onTapReport();
      verify(() => navigator.openReportForm(any()));
    },
  );

  setUp(() {
    model = PostSharePresentationModel.initial(
      PostShareInitialParams(
        post: Stubs.textPost,
      ),
    );
    navigator = MockPostShareNavigator();
    presenter = PostSharePresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.getRecommendedChatsUseCase,
      ChatMocks.sendChatMessageUseCase,
      Mocks.userStore,
    );
  });
}

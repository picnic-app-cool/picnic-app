import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_page.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late ReportedMessagePage page;
  late ReportedMessageInitialParams initParams;
  late ReportedMessagePresentationModel model;
  late ReportedMessagePresenter presenter;
  late ReportedMessageNavigator navigator;

  void _initMvp() {
    initParams = ReportedMessageInitialParams(
      circleId: Stubs.circle.id,
      reportedMessageId: Stubs.textPost.id,
      reportId: Stubs.id,
      chatMessagesFeed: Stubs.chatMessagesFeed,
    );
    model = ReportedMessagePresentationModel.initial(initParams);
    navigator = ReportedMessageNavigator(Mocks.appNavigator);
    presenter = ReportedMessagePresenter(
      model,
      Mocks.resolveReportUseCase,
      navigator,
    );
    page = ReportedMessagePage(presenter: presenter);
    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.circle.id))
        .thenAnswer((_) => successFuture(Stubs.circle));
    when(
      () => CirclesMocks.getRelatedMessagesUseCase.execute(
        messageId: Stubs.chatMessage.id,
        relatedMessagesCount: 20,
      ),
    ).thenAnswer(
      (_) => successFuture([
        Stubs.chatMessage.copyWith(content: 'Hello everyone'),
      ]),
    );
  }

  await screenshotTest(
    "reported_message_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ReportedMessagePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

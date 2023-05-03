import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/circles/domain/model/resolve_report_failure.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late ReportedMessagePresentationModel model;
  late ReportedMessagePresenter presenter;
  late MockReportedMessageNavigator navigator;

  tearDown(() {
    reset(Mocks.resolveReportUseCase);
  });

  test(
    'tapping close should call navigator to close the widget',
    () {
      //GIVEN

      //WHEN
      presenter.onTapClose();

      //THEN
      verify(() => navigator.close());
    },
  );

  test(
    'tapping ban should call navigator to open ban user and resolve report if user was banned',
    () async {
      //GIVEN
      when(() => navigator.openBanUser(any())).thenAnswer((_) => Future.value(true));
      when(() => navigator.closeWithResult(any())).thenAnswer((_) => Future.value(unit));
      when(
        () => Mocks.resolveReportUseCase.execute(
          circleId: Stubs.circle.id,
          reportId: Stubs.id,
          fullFill: false,
        ),
      ).thenAnswer((_) => successFuture(unit));

      //WHEN
      await presenter.onTapBanUser();

      //THEN
      verify(() => navigator.openBanUser(any()));
      verify(
        () => Mocks.resolveReportUseCase.execute(
          circleId: Stubs.circle.id,
          reportId: Stubs.id,
          fullFill: false,
        ),
      );
    },
  );

  test(
    'tapping on resolve with no action should navigate to resolve with no action confirmation page and should call resolveReportUseCase if user confirms',
    () async {
      //GIVEN
      when(() => navigator.openResolveReportWithNoAction(any())).thenAnswer((_) => Future.value(true));
      when(
        () => Mocks.resolveReportUseCase.execute(
          circleId: Stubs.circle.id,
          reportId: Stubs.id,
          fullFill: false,
        ),
      ).thenAnswer((_) => successFuture(unit));

      //WHEN
      await presenter.onTapResolveWithNoAction();

      //THEN
      verify(() => navigator.openResolveReportWithNoAction(any()));
      verify(
        () => Mocks.resolveReportUseCase.execute(
          circleId: Stubs.circle.id,
          reportId: Stubs.id,
          fullFill: false,
        ),
      );
    },
  );
  test(
      'tapping on resolve with no action should navigate to resolve with no action confirmation page and should not call resolveReportUseCase if user doesnt confirm',
      () async {
    //GIVEN
    when(() => navigator.openResolveReportWithNoAction(any())).thenAnswer((_) => Future.value(false));
    when(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: false,
      ),
    ).thenAnswer((_) => successFuture(unit));

    //WHEN
    await presenter.onTapResolveWithNoAction();

    //THEN
    verify(() => navigator.openResolveReportWithNoAction(any()));
    verifyNever(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: false,
      ),
    );
  });

  test(
      'tapping on remove message should navigate to remove reason input and should call resolveReportUseCase if user provides a reason',
      () async {
    //GIVEN
    when(() => navigator.openRemoveReason(any())).thenAnswer((_) => Future.value('reason'));
    when(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: true,
      ),
    ).thenAnswer((_) => successFuture(unit));

    //WHEN
    await presenter.onTapRemove();
    //THEN
    verify(() => navigator.openRemoveReason(any()));
    verify(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: true,
      ),
    );
  });

  test(
      'tapping on remove message should navigate to remove reason input and should not call resolveReportUseCase if user does not provide a reason',
      () async {
    //GIVEN
    when(() => navigator.openRemoveReason(any())).thenAnswer((_) => Future.value());
    when(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: true,
      ),
    ).thenAnswer((_) => successFuture(unit));

    //WHEN
    await presenter.onTapRemove();
    //THEN
    verify(() => navigator.openRemoveReason(any()));
    verifyNever(
      () => Mocks.resolveReportUseCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.id,
        fullFill: true,
      ),
    );
  });

  test(
    'tapping ban should call navigator to open ban user and display error if resolve report fails',
    () async {
      //GIVEN
      when(() => navigator.openBanUser(any())).thenAnswer((_) => Future.value(true));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
      when(
        () => Mocks.resolveReportUseCase.execute(
          circleId: Stubs.circle.id,
          reportId: Stubs.id,
          fullFill: false,
        ),
      ).thenAnswer((_) => failFuture(const ResolveReportFailure.unknown()));

      //WHEN
      await presenter.onTapBanUser();

      //THEN
      verify(() => navigator.openBanUser(any()));
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'tapping ban should call navigator to open ban user but do not resolve the report if user was not banned',
    () async {
      //GIVEN
      when(() => navigator.openBanUser(any())).thenAnswer((_) => Future.value(false));

      //WHEN
      await presenter.onTapBanUser();

      //THEN
      verify(() => navigator.openBanUser(any()));
      verifyNever(
        () => Mocks.resolveReportUseCase.execute(
          circleId: any(named: 'circleId'),
          reportId: any(named: 'reportId'),
          fullFill: any(named: 'fullFill'),
        ),
      );
    },
  );

  setUp(() {
    model = ReportedMessagePresentationModel.initial(
      ReportedMessageInitialParams(
        circleId: Stubs.circle.id,
        reportedMessageId: Stubs.textPost.id,
        reportedMessageAuthor: Stubs.postAuthor,
        reportId: Stubs.id,
        chatMessagesFeed: Stubs.chatMessagesFeed,
      ),
    );
    navigator = MockReportedMessageNavigator();
    presenter = ReportedMessagePresenter(
      model,
      Mocks.resolveReportUseCase,
      navigator,
    );
  });
}

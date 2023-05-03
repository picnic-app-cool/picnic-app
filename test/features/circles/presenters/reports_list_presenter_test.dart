import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presenter.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../posts/mocks/posts_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late ReportsListPresentationModel model;
  late ReportsListPresenter presenter;
  late MockReportsListNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  test(
    'tapping on a report should open report details when the report has been resolved',
    () async {
      //GIVEN
      when(() => navigator.openReportDetails(any())).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapReport(Stubs.messageReport.copyWith(status: ResolveStatus.resolved));

      //THEN
      verify(() => navigator.openReportDetails(any()));
    },
  );

  test(
    'tapping on a resolved report of type post should open post details',
    () async {
      //GIVEN
      when(() => navigator.openPostDetails(any())).thenAnswer(
        (_) => Future.value(
          Stubs.postRouteResult.copyWith(userBanned: true),
        ),
      );
      when(
        () => PostsMocks.getPostUseCase.execute(
          postId: Stubs.postReport.post.id,
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.imagePost),
      );
      when(
        () => CirclesMocks.getReportsUseCase.execute(
          circleId: any(named: 'circleId'),
          nextPageCursor: any(named: 'nextPageCursor'),
          filterBy: CircleReportsFilterBy.unresolved,
        ),
      ).thenAnswer(
        (invocation) => successFuture(
          PaginatedList.singlePage([Stubs.postReport]),
        ),
      );
      when(
        () => CirclesMocks.getCircleDetailsUseCase.execute(
          circleId: any(named: 'circleId'),
        ),
      ).thenAnswer(
        (_) {
          return successFuture(Stubs.circle);
        },
      );

      //WHEN
      await presenter.onTapReport(Stubs.postReport.copyWith(status: ResolveStatus.unresolved));

      //THEN
      verify(() => navigator.openPostDetails(any()));
    },
  );

  test(
    'tapping on a resolved report of type message should open the reported message',
    () async {
      //GIVEN
      when(() => navigator.openReportedMessage(any())).thenAnswer((_) => Future.value(true));
      when(
        () => CirclesMocks.getRelatedChatMessagesFeedUseCase.execute(
          circleId: Stubs.circle.id,
          messageId: Stubs.messageReport.messageId,
          relatedMessagesCount: 20,
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.chatMessagesFeed),
      );
      when(
        () => CirclesMocks.getReportsUseCase.execute(
          circleId: any(named: 'circleId'),
          nextPageCursor: any(named: 'nextPageCursor'),
          filterBy: CircleReportsFilterBy.unresolved,
        ),
      ).thenAnswer(
        (invocation) => successFuture(
          PaginatedList.singlePage([Stubs.postReport]),
        ),
      );

      //WHEN
      await presenter.onTapReport(Stubs.messageReport.copyWith(status: ResolveStatus.unresolved));

      //THEN
      verify(() => navigator.openReportedMessage(any()));
    },
  );

  test(
    'tapping on an unresolved report of type comment should open comments chat',
    () async {
      //GIVEN
      when(() => navigator.openCommentChat(any())).thenAnswer((_) => Future.value());
      when(() => PostsMocks.getCommentByIdUseCase.execute(commentId: Stubs.commentReport.commentId))
          .thenAnswer((_) => successFuture(Stubs.comments));
      when(
        () => PostsMocks.getPostUseCase.execute(
          postId: Stubs.comments.postId,
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.linkPost),
      );
      when(
        () => CirclesMocks.getReportsUseCase.execute(
          circleId: any(named: 'circleId'),
          nextPageCursor: any(named: 'nextPageCursor'),
          filterBy: CircleReportsFilterBy.unresolved,
        ),
      ).thenAnswer(
        (invocation) => successFuture(
          PaginatedList.singlePage([Stubs.postReport]),
        ),
      );

      //WHEN
      await presenter.onTapReport(Stubs.commentReport.copyWith(status: ResolveStatus.unresolved));

      //THEN
      verify(() => navigator.openCommentChat(any()));
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = ReportsListPresentationModel.initial(
      ReportsListInitialParams(circle: Stubs.circle),
      Mocks.featureFlagsStore,
    );
    navigator = MockReportsListNavigator();
    presenter = ReportsListPresenter(
      model,
      navigator,
      CirclesMocks.getReportsUseCase,
      PostsMocks.getPostUseCase,
      CirclesMocks.getRelatedChatMessagesFeedUseCase,
      PostsMocks.getCommentByIdUseCase,
      CirclesMocks.getCircleDetailsUseCase,
    );
  });
}

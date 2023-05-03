import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ChatMyCirclesPresentationModel model;
  late ChatMyCirclesPresenter presenter;
  late MockChatMyCirclesNavigator navigator;

  setUp(() {
    model = ChatMyCirclesPresentationModel.initial(
      const ChatMyCirclesInitialParams(),
      Mocks.currentTimeProvider,
    );
    navigator = MockChatMyCirclesNavigator();
    presenter = ChatMyCirclesPresenter(
      model,
      navigator,
      ChatMocks.getCircleChatsUseCase,
      Mocks.debouncer,
    );
  });

  test(
    'changing search text should use debouncer',
    () {
      //GIVEN
      when(
        () => Mocks.debouncer.debounce(
          const LongDuration(),
          any(),
        ),
      ).thenAnswer(
        (_) => unit,
      );

      //WHEN
      presenter.onChangedSearchText('some text');

      //THEN
      verify(
        () => Mocks.debouncer.debounce(
          const LongDuration(),
          any(),
        ),
      ).called(1);
    },
  );

  test(
    'loading more should call getCircleChatsUseCase execution',
    () async {
      //GIVEN
      when(
        () => ChatMocks.getCircleChatsUseCase.execute(
          searchQuery: any(named: 'searchQuery'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).thenAnswer(
        (_) => successFuture(PaginatedList.singlePage([Stubs.chat])),
      );

      //WHEN
      await presenter.loadMore();

      //THEN
      verify(
        () => ChatMocks.getCircleChatsUseCase.execute(
          searchQuery: any(named: 'searchQuery'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).called(1);
    },
  );

  test(
    'tapping circle should call openCircleChat() from navigator to open Circle Chat',
    () {
      //GIVEN
      when(
        () => navigator.openCircleChat(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      presenter.emit(
        model.copyWith(
          circleChats: PaginatedList.singlePage([Stubs.chat]),
        ),
      );

      //WHEN
      presenter.onTapCircle(Stubs.basicChat);

      //THEN
      verify(
        () => navigator.openCircleChat(any()),
      ).called(1);
    },
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late BlacklistedWordsPresentationModel model;
  late BlacklistedWordsPresenter presenter;
  late MockBlacklistedWordsNavigator navigator;

  test(
    'verify that on search of a word should trigger debouncer and call getBlacklistedWordsUseCase',
    () async {
      //GIVEN
      const someWord = 'word';
      when(() => Mocks.debouncer.debounce(const LongDuration(), any())).thenAnswer((invocation) async {
        final callback = invocation.positionalArguments[1] as Future<void> Function();
        await callback();
      });
      when(
        () => CirclesMocks.getBlacklistedWordsUseCase.execute(
          circleId: Stubs.id,
          cursor: const Cursor.firstPage(),
          searchQuery: someWord,
        ),
      ).thenAnswer(
        (_) => successFuture(const PaginatedList.singlePage(['word1', 'word2'])),
      );

      //WHEN
      presenter.onSearchTextChanged(someWord);

      //THEN
      verify(() => Mocks.debouncer.debounce(const LongDuration(), any()));
      expect(presenter.state.searchQuery, someWord);
      verify(
        () => CirclesMocks.getBlacklistedWordsUseCase.execute(
          circleId: Stubs.id,
          cursor: const Cursor.firstPage(),
          searchQuery: someWord,
        ),
      );
    },
  );

  test(
    'tapping "no" should trigger close ',
    () async {
      //GIVEN
      when(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapDeleteWord("word");

      //THEN
      verify(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      );
    },
  );

  test(
    'tapping "add word" should open AddBlackListWordPage',
    () async {
      //GIVEN
      when(
        () => navigator.openAddWordBlackList(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapAddWord();

      //THEN
      verify(
        () => navigator.openAddWordBlackList(any()),
      );
    },
  );

  test(
    'adding new blacklist word should trigger list reload',
    () async {
      //GIVEN
      when(
        () => navigator.openAddWordBlackList(any()),
      ).thenAnswer((_) => Future.value(true));

      when(
        () => CirclesMocks.getBlacklistedWordsUseCase.execute(
          circleId: Stubs.id,
          cursor: const Cursor.firstPage(),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.singlePage(['word1', 'word2', 'word3'])));

      //WHEN
      await presenter.onTapAddWord();

      //THEN
      verify(
        () => navigator.openAddWordBlackList(any()),
      );

      verify(
        () => CirclesMocks.getBlacklistedWordsUseCase.execute(
          circleId: Stubs.id,
          cursor: const Cursor.firstPage(),
        ),
      );
      expect(presenter.state.words.items.length, 3);
      expect(presenter.state.words.items[0], 'word1');
      expect(presenter.state.words.items[1], 'word2');
      expect(presenter.state.words.items[2], 'word3');
    },
  );

  test(
    'canceling adding new word should not trigger list reload',
    () async {
      //GIVEN
      when(
        () => navigator.openAddWordBlackList(any()),
      ).thenAnswer((_) => Future.value(false));

      //WHEN
      await presenter.onTapAddWord();

      //THEN
      verify(
        () => navigator.openAddWordBlackList(any()),
      );

      verifyNever(
        () => CirclesMocks.getBlacklistedWordsUseCase.execute(
          circleId: Stubs.id,
          cursor: const Cursor.firstPage(),
        ),
      );
    },
  );
  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = BlacklistedWordsPresentationModel.initial(
      BlacklistedWordsInitialParams(circleId: Stubs.id),
      Mocks.featureFlagsStore,
    );
    navigator = MockBlacklistedWordsNavigator();
    presenter = BlacklistedWordsPresenter(
      model,
      navigator,
      CirclesMocks.getBlacklistedWordsUseCase,
      CirclesMocks.removeBlacklistedWordsUseCase,
      Mocks.debouncer,
    );
  });
}

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_navigator.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/remove_blacklisted_words_use_case.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class BlacklistedWordsPresenter extends Cubit<BlacklistedWordsViewModel> {
  BlacklistedWordsPresenter(
    super.model,
    this.navigator,
    this._getBlacklistedWordsUseCase,
    this._removeBlacklistedWordsUseCase,
    this._debouncer,
  );

  final BlacklistedWordsNavigator navigator;
  final GetBlacklistedWordsUseCase _getBlacklistedWordsUseCase;
  final RemoveBlacklistedWordsUseCase _removeBlacklistedWordsUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  BlacklistedWordsPresentationModel get _model => state as BlacklistedWordsPresentationModel;

  void onSearchTextChanged(String value) {
    if (value != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () async {
          tryEmit(_model.copyWith(searchQuery: value));
          await getWords(fromScratch: true);
        },
      );
    }
  }

  Future<void> onTapEditWord(String word) async {
    final wordsChanged = await navigator.openAddWordBlackList(
          AddBlackListWordInitialParams(
            circleId: _model.circleId,
            word: word,
          ),
        ) ??
        false;
    if (wordsChanged) {
      await getWords(fromScratch: true);
    }
  }

  Future<void> onTapAddWord() async {
    final wordsChanged = await navigator.openAddWordBlackList(
          AddBlackListWordInitialParams(
            circleId: _model.circleId,
          ),
        ) ??
        false;
    if (wordsChanged) {
      await getWords(fromScratch: true);
    }
  }

  void onTapDeleteWord(String word) => navigator.showConfirmationBottomSheet(
        title: appLocalizations.deleteWord,
        message: appLocalizations.deleteWordMessage,
        primaryAction: ConfirmationAction(
          roundedButton: true,
          title: appLocalizations.deleteWord,
          action: () async {
            _onTapNo();
            await _removeWord(word: word);
          },
        ),
        secondaryAction: ConfirmationAction.negative(
          action: () => _onTapNo(),
        ),
      );

  Future<void> getWords({bool fromScratch = false}) {
    _model.getWordsOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _getBlacklistedWordsUseCase.execute(
        circleId: _model.circleId,
        cursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
        searchQuery: _model.searchQuery,
      ),
    );

    tryEmit(_model.copyWith(getWordsOperation: operation));

    return operation.value.doOn(
      success: (words) => tryEmit(
        fromScratch ? _model.copyWith(words: words) : _model.byAppendingWords(words),
      ),
      fail: (fail) => navigator.showError(fail.displayableFailure()),
    );
  }

  void _onTapNo() => navigator.close();

  Future<void> _removeWord({required String word}) {
    return _removeBlacklistedWordsUseCase.execute(
      circleId: _model.circleId,
      words: [word],
    ).doOn(
      success: (_) => tryEmit(_model.byRemovingWord(word)),
      fail: (fail) => navigator.showError(fail.displayableFailure()),
    );
  }
}

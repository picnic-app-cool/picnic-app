import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_navigator.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/add_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/remove_blacklisted_words_use_case.dart';

class AddBlackListWordPresenter extends Cubit<AddBlackListWordViewModel> {
  AddBlackListWordPresenter(
    super.model,
    this.navigator,
    this._addBlacklistedWordsUseCase,
    this._removeBlackListedWordsUseCase,
  );

  final AddBlackListWordNavigator navigator;
  final AddBlacklistedWordsUseCase _addBlacklistedWordsUseCase;
  final RemoveBlacklistedWordsUseCase _removeBlackListedWordsUseCase;

  // ignore: unused_element
  AddBlackListWordPresentationModel get _model => state as AddBlackListWordPresentationModel;

  void onWordsInputChanged(String value) {
    if (value != _model.newWord) {
      tryEmit(_model.copyWith(newWord: value));
    }
  }

  void onTapClose() => navigator.closeWithResult(false);

  void onTapAddWords() {
    if (_model.editedWord.isNotEmpty) {
      _removeBlackListedWordsUseCase.execute(
        circleId: _model.circleId,
        words: [_model.editedWord],
      );
    }

    _addBlacklistedWordsUseCase
        .execute(
          circleId: _model.circleId,
          words: _model.newWord,
        )
        .doOn(
          success: (_) => navigator.closeWithResult(true),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}

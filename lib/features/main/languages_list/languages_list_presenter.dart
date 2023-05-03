import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_navigator.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart';

class LanguagesListPresenter extends Cubit<LanguagesListViewModel> {
  LanguagesListPresenter(
    LanguagesListPresentationModel model,
    this.navigator,
    this._getLanguagesListUseCase,
  ) : super(model);

  final LanguagesListNavigator navigator;
  final GetLanguagesListUseCase _getLanguagesListUseCase;

  // ignore: unused_element
  LanguagesListPresentationModel get _model => state as LanguagesListPresentationModel;

  void onInit() {
    _getLanguagesListUseCase.execute().observeStatusChanges(
          (result) => tryEmit(
            _model.copyWith(languagesListResult: result),
          ),
        );
  }

  void onLanguageSelected(Language selectedLanguage) => tryEmit(
        _model.copyWith(
          selectedLanguage: selectedLanguage,
        ),
      );

  void onTapConfirm() => navigator.closeWithResult(_model.selectedLanguage);

  void onTapNo() => navigator.close();
}

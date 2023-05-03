import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_language_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_current_user_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart';
import 'package:picnic_app/features/settings/language/language_navigator.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';

class LanguagePresenter extends Cubit<LanguageViewModel> {
  LanguagePresenter(
    LanguagePresentationModel model,
    this.navigator,
    this._getLanguagesUseCase,
    this._getPrivateProfileUseCase,
    this._setLanguageUseCase,
    this._updateCurrentUserUseCase,
    this._userStore,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final LanguageNavigator navigator;
  final GetLanguagesListUseCase _getLanguagesUseCase;
  final SetLanguageUseCase _setLanguageUseCase;
  final GetPrivateProfileUseCase _getPrivateProfileUseCase;
  final UpdateCurrentUserUseCase _updateCurrentUserUseCase;
  final UserStore _userStore;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  LanguagePresentationModel get _model => state as LanguagePresentationModel;

  Future<void> onInit() async {
    getLanguages();
    getSelectedLanguage();
  }

  void onTapSelectLanguage(Language language) => _setLanguageUseCase.execute(languagesCodes: [language.code]).doOn(
        success: (success) {
          _logAnalyticsEventUseCase.execute(
            AnalyticsEvent.tap(
              target: AnalyticsTapTarget.settingsLanguageButtonTap,
              targetValue: language.code,
            ),
          );
          tryEmit(_model.copyWith(selectedLanguage: language.code));
          _onLanguageUpdated(language.code);
        },
      ).doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void getLanguages() => _getLanguagesUseCase
          .execute() //
          .observeStatusChanges(
        (result) {
          tryEmit(_model.copyWith(languageListResult: result));
        },
      );

  void onTapShowInfo() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsLanguageInfoTap,
      ),
    );
    navigator.showLanguageInfo();
  }

  void getSelectedLanguage() => _getPrivateProfileUseCase.execute().doOn(
        success: (profile) => tryEmit(_model.copyWith(selectedLanguage: profile.languages.first)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void searchChanged(String query) => notImplemented();

  void _onLanguageUpdated(String language) {
    _userStore.privateProfile.languages.first = language;
    _updateCurrentUserUseCase.execute(_userStore.privateProfile);
  }
}

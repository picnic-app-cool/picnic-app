import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_initial_params.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/main_mock_definitions.dart';

void main() {
  late LanguagesListPresentationModel model;
  late LanguagesListPresenter presenter;
  late MockLanguagesListNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LanguagesListPresentationModel.initial(
      const LanguagesListInitialParams(
        selectedLanguage: Language.empty(),
      ),
    );
    navigator = MockLanguagesListNavigator();
    presenter = LanguagesListPresenter(
      model,
      navigator,
      Mocks.getLanguagesListUseCase,
    );
  });
}

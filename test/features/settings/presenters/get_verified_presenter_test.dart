import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presenter.dart';

import '../mocks/settings_mock_definitions.dart';

void main() {
  late GetVerifiedPresentationModel model;
  late GetVerifiedPresenter presenter;
  late MockGetVerifiedNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = GetVerifiedPresentationModel.initial(const GetVerifiedInitialParams());
    navigator = MockGetVerifiedNavigator();
    presenter = GetVerifiedPresenter(
      model,
      navigator,
    );
  });
}

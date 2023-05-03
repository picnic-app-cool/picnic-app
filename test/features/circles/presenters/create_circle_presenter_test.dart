import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presenter.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../create_circle/mocks/create_circle_mock_definitions.dart';

void main() {
  late CreateCirclePresentationModel model;
  late CreateCirclePresenter presenter;
  late MockCreateCircleNavigator navigator;

  final formInputWithExpectedValidation = <CreateCircleForm, bool>{
    // createCircleEnabled is enabled
    CreateCircleForm(
      emoji: '😀',
      name: 'roblox',
      description: 'blabla',
      language: const Language.empty().copyWith(
        title: 'english',
      ),
      group: const GroupWithCircles.empty().copyWith(id: const Id('id')),
      visibility: CircleVisibility.opened,
      image: '',
      userSelectedNewImage: false,
      userSelectedNewCover: false,
      coverImage: '',
    ): true,
    // if name is empty then createCircleEnabled is not enabled
    CreateCircleForm(
      emoji: '😀',
      name: '',
      description: 'blabla',
      language: const Language.empty().copyWith(
        title: 'english',
      ),
      group: const GroupWithCircles.empty().copyWith(id: const Id('id')),
      visibility: CircleVisibility.opened,
      image: '',
      userSelectedNewImage: false,
      userSelectedNewCover: false,
      coverImage: '',
    ): false,
    // if group is empty then createCircleEnabled is not enabled
    CreateCircleForm(
      emoji: '😀',
      name: 'roblox',
      description: 'blabla',
      language: const Language.empty().copyWith(
        title: 'english',
      ),
      group: const GroupWithCircles.empty(),
      visibility: CircleVisibility.opened,
      image: '',
      userSelectedNewImage: false,
      userSelectedNewCover: false,
      coverImage: '',
    ): false,
    // if emoji is empty then createCircleEnabled is not enabled
    CreateCircleForm(
      emoji: '',
      name: 'roblox',
      description: 'blabla',
      language: const Language.empty().copyWith(
        title: 'english',
      ),
      group: const GroupWithCircles.empty().copyWith(id: const Id('id')),
      visibility: CircleVisibility.opened,
      image: '',
      userSelectedNewImage: false,
      userSelectedNewCover: false,
      coverImage: '',
    ): false,
    // if description is empty then createCircleEnabled is not enabled
    CreateCircleForm(
      emoji: '😀',
      name: 'roblox',
      description: '',
      language: const Language.empty().copyWith(
        title: 'english',
      ),
      group: const GroupWithCircles.empty().copyWith(id: const Id('id')),
      visibility: CircleVisibility.opened,
      image: '',
      userSelectedNewImage: false,
      userSelectedNewCover: false,
      coverImage: '',
    ): false,
  };

  formInputWithExpectedValidation.forEach((form, expectedValid) {
    test("expect that based input form the expected valid state is present", () {
      presenter.emit(
        model.copyWith(createCircleForm: form),
      );

      expect(presenter.state.createCircleEnabled, expectedValid);
    });
  });

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    model = CreateCirclePresentationModel.initial(
      const CreateCircleInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockCreateCircleNavigator();
    presenter = CreateCirclePresenter(
      model,
      navigator,
    );
  });
}

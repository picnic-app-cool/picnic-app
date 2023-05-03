import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../create_circle/mocks/create_circle_mock_definitions.dart';
import '../../posts/mocks/posts_mocks.dart';

void main() {
  late CircleCreationSuccessPresentationModel model;
  late CircleCreationSuccessPresenter presenter;
  late MockCircleCreationSuccessNavigator navigator;

  void _initMvp({
    required bool createCircleWithoutPost,
    required CreatePostInput createPostInput,
  }) {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    model = CircleCreationSuccessPresentationModel.initial(
      CircleCreationSuccessInitialParams(
        circle: Stubs.circle,
        createPostInput: createPostInput,
        createCircleWithoutPost: createCircleWithoutPost,
      ),
      Mocks.featureFlagsStore,
    );
    navigator = MockCircleCreationSuccessNavigator();
    presenter = CircleCreationSuccessPresenter(
      model,
      navigator,
      Mocks.getContactsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.getPhoneContactsUseCase,
      PostsMocks.createPostUseCase,
      Mocks.debouncer,
    );
  }

  test(
    'onTapAwesome() should close until main if circle is empty',
    () async {
      // GIVEN
      _initMvp(
        createCircleWithoutPost: false,
        createPostInput: Stubs.createTextPostInput.copyWith(circleId: const Id.empty()),
      );
      when(() => navigator.closeUntilMain()).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapAwesome();

      // THEN
      verify(() => navigator.closeUntilMain());
    },
  );

  test(
    'onTapAwesome() should call CreatePostUseCase and close until main if circle is not empty',
    () async {
      // GIVEN
      _initMvp(
        createCircleWithoutPost: false,
        createPostInput: Stubs.createTextPostInput,
      );
      when(() => navigator.closeUntilMain()).thenAnswer((_) => Future.value());
      when(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')))
          .thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapAwesome();

      // THEN
      verify(() => navigator.closeUntilMain());
      verify(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')));
    },
  );

  test(
    'onTapAwesome() should close until main and open private profile if createCircleWithoutPost is true',
    () async {
      // GIVEN
      _initMvp(
        createCircleWithoutPost: true,
        createPostInput: Stubs.createTextPostInput,
      );
      when(() => navigator.closeUntilMain()).thenAnswer((_) => Future.value());
      when(() => navigator.openPrivateProfile(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapAwesome();

      // THEN
      verify(() => navigator.closeUntilMain());
      verify(() => navigator.openPrivateProfile(any()));
    },
  );
}

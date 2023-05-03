import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late SelectCirclePresentationModel model;
  late SelectCirclePresenter presenter;
  late MockSelectCircleNavigator navigator;

  test(
    'should call CreatePostUseCase and close until main if circle is not empty',
    () async {
      // GIVEN
      when(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')))
          .thenAnswer((_) => Future.value());
      when(() => navigator.closeUntilMain()).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapCircle(Stubs.circle);

      // THEN
      verify(() => navigator.closeUntilMain());
      verify(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')));
    },
  );

  setUp(() {
    model = SelectCirclePresentationModel.initial(
      SelectCircleInitialParams(createPostInput: Stubs.createTextPostInput),
    );
    navigator = MockSelectCircleNavigator();
    presenter = SelectCirclePresenter(
      model,
      navigator,
      Mocks.getPostCreationCirclesUseCase,
      PostsMocks.createPostUseCase,
      Mocks.debouncer,
    );
  });
}

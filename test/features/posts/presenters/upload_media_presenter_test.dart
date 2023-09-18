import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late UploadMediaPresentationModel model;
  late UploadMediaPresenter presenter;
  late MockUploadMediaNavigator navigator;
  late UploadMediaInitialParams initialParams;

  void _initMvp({CreatePostInput createPostInput = const CreatePostInput.empty()}) {
    navigator = MockUploadMediaNavigator();
    initialParams = UploadMediaInitialParams(createPostInput: createPostInput);
    model = UploadMediaPresentationModel.initial(
      initialParams,
    );
    presenter = UploadMediaPresenter(
      model,
      navigator,
      PostsMocks.createPostUseCase,
    );
    when(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')))
        .thenAnswer((_) => Future.value());
  }

  test(
    'should open circle selection if circle id is empty',
    () async {
      _initMvp();
      when(() => navigator.openSelectCircle(any())).thenAnswer((invocation) => Future.value());
      await presenter.onTapPost();
      verify(() => navigator.openSelectCircle(any()));
    },
  );

  test(
    'should call CreatePostUseCase and open circle details page if circle is not empty',
    () async {
      final createPostInput = const CreatePostInput.empty().copyWith(circleId: Stubs.createImagePostInput.circleId);
      _initMvp(createPostInput: createPostInput);
      when(() => navigator.openCircleDetails(any())).thenAnswer((_) => Future.value());
      await presenter.onTapPost();
      verify(() => navigator.openCircleDetails(captureAny()));
      verify(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')));
    },
  );
}

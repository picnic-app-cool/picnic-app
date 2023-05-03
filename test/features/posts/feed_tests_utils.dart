import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';
import 'mocks/posts_mocks.dart';

void mockCommentsPreview() {
  reRegister<GetCommentsPreviewUseCase>(PostsMocks.getCommentsPreviewUseCase);

  when(
    () => PostsMocks.getCommentsPreviewUseCase.execute(
      postId: any(named: 'postId'),
      count: any(named: 'count'),
    ),
  ).thenAnswer((_) => successFuture(Stubs.commentsPreview));

  when(() => PostsMocks.getPostUseCase.execute(postId: any(named: 'postId')))
      .thenAnswer((_) => successFuture(Stubs.pollPost));
}

void mockCameraController() {
  reRegister<PicnicCameraController>(Mocks.cameraController);
  when(() => Mocks.cameraController.isFlashEnabled).thenReturn(false);
  when(() => Mocks.cameraController.videoRecordingState).thenReturn(VideoRecordingState.notRecording);
  when(() => Mocks.cameraController.isReady).thenAnswer((_) => false);
  when(() => Mocks.cameraController.videoRecordingDuration).thenReturn(const Duration(seconds: 12));

  when(() => Mocks.cameraController.startVideoRecording()).thenAnswer((_) => Future.value());
  when(() => Mocks.cameraController.enable()).thenAnswer((_) => Future.value());
}

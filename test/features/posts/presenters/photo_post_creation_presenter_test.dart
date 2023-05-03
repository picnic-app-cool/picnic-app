import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late PhotoPostCreationPresentationModel model;
  late PhotoPostCreationPresenter presenter;
  late MockPhotoPostCreationNavigator navigator;
  late MockSavePhotoToGalleryUseCase savePhotoToGalleryUseCase;
  late MockImageWatermarkUseCase imageWatermarkUseCase;
  late MockUserStore userStore;

  test('adding watermark to an image should call the add watermark navigator', () async {
    // GIVEN
    // WHEN
    await presenter.saveWatermarkPhoto('');

    // THEN
    verify(
      () => imageWatermarkUseCase.execute(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).called(1);
  });

  test('saving watermark photo should call save photo to gallery use case', () async {
    // GIVEN
    // WHEN
    await presenter.saveWatermarkPhoto('');

    // THEN
    verify(
      () => savePhotoToGalleryUseCase.execute(path: any(named: 'path')),
    ).called(1);
  });

  setUp(() {
    model = PhotoPostCreationPresentationModel.initial(
      PhotoPostCreationInitialParams(
        onTapPost: (_) {},
        nativeMediaPickerPostCreationEnabled: false,
      ),
    );
    navigator = MockPhotoPostCreationNavigator();
    savePhotoToGalleryUseCase = MockSavePhotoToGalleryUseCase();
    imageWatermarkUseCase = MockImageWatermarkUseCase();
    userStore = MockUserStore();
    presenter = PhotoPostCreationPresenter(
      model,
      navigator,
      savePhotoToGalleryUseCase,
      imageWatermarkUseCase,
      userStore,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
    );

    when(() => userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => imageWatermarkUseCase.execute(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) => successFuture(''));
    when(
      () => savePhotoToGalleryUseCase.execute(path: any(named: 'path')),
    ).thenAnswer((_) => successFuture(unit));
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/use_cases/save_attachment_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late SaveAttachmentUseCase useCase;

  setUp(() {
    useCase = SaveAttachmentUseCase(
      Mocks.downloadRepository,
      Mocks.imageWatermarkUseCase,
      Mocks.savePhotoToGalleryUseCase,
      Mocks.saveVideoToGalleryUseCase,
    );
  });

  test('should successfully return from repository', () async {
    // GIVEN
    when(
      () => Mocks.downloadRepository.download(url: any(named: 'url')),
    ).thenAnswer((_) => successFuture(''));
    when(
      () => Mocks.savePhotoToGalleryUseCase.execute(path: any(named: 'path')),
    ).thenAnswer((_) => successFuture(unit));
    when(
      () => Mocks.saveVideoToGalleryUseCase.execute(path: any(named: 'path')),
    ).thenAnswer((_) => successFuture(unit));
    when(
      () => Mocks.imageWatermarkUseCase.execute(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) => successFuture(''));

    // WHEN
    final result = await useCase.execute(attachment: Stubs.attachment, username: '');

    // THEN
    expect(result.isSuccess, true);
    verify(
      () => Mocks.downloadRepository.download(url: any(named: 'url')),
    ).called(1);
    verify(
      () => Mocks.imageWatermarkUseCase.execute(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).called(1);
    verify(
      () => Mocks.savePhotoToGalleryUseCase.execute(path: any(named: 'path')),
    ).called(1);
    verifyNever(
      () => Mocks.saveVideoToGalleryUseCase.execute(path: any(named: 'path')),
    );
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<SaveAttachmentUseCase>();
    expect(useCase, isNotNull);
  });
}

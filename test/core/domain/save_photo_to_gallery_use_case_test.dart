import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/save_photo_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/use_cases/save_photo_to_gallery_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SavePhotoToGalleryUseCase useCase;

  setUp(() {
    useCase = SavePhotoToGalleryUseCase(Mocks.phoneGalleryRepository);
  });

  test('should successfully return from repository when save photo', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.savePhoto(path: any(named: 'path')),
    ).thenAnswer((_) => successFuture(unit));

    // WHEN
    final result = await useCase.execute(path: '');

    // THEN
    expect(result.isSuccess, true);
    verify(
      () => Mocks.phoneGalleryRepository.savePhoto(path: any(named: 'path')),
    ).called(1);
  });

  test('should fail from repository when save photo', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.savePhoto(path: any(named: 'path')),
    ).thenAnswer((_) => failFuture(const SavePhotoToGalleryFailure.unknown()));

    // WHEN
    final result = await useCase.execute(path: '');

    // THEN
    expect(result.isFailure, true);
    verify(
      () => Mocks.phoneGalleryRepository.savePhoto(path: any(named: 'path')),
    ).called(1);
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<SavePhotoToGalleryUseCase>();
    expect(useCase, isNotNull);
  });
}

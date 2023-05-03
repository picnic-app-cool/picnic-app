import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/save_video_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/use_cases/save_video_to_gallery_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SaveVideoToGalleryUseCase useCase;

  setUp(() {
    useCase = SaveVideoToGalleryUseCase(Mocks.phoneGalleryRepository);
  });

  test('should successfully return from repository when save video', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.saveVideo(path: any(named: 'path')),
    ).thenAnswer((_) => successFuture(unit));

    // WHEN
    final result = await useCase.execute(path: '');

    // THEN
    expect(result.isSuccess, true);
    verify(
      () => Mocks.phoneGalleryRepository.saveVideo(path: any(named: 'path')),
    ).called(1);
  });

  test('should fail from repository when save video', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.saveVideo(path: any(named: 'path')),
    ).thenAnswer((_) => failFuture(const SaveVideoToGalleryFailure.unknown()));

    // WHEN
    final result = await useCase.execute(path: '');

    // THEN
    expect(result.isFailure, true);
    verify(
      () => Mocks.phoneGalleryRepository.saveVideo(path: any(named: 'path')),
    ).called(1);
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<SaveVideoToGalleryUseCase>();
    expect(useCase, isNotNull);
  });
}

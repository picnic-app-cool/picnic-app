import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/image_watermark_failure.dart';
import 'package:picnic_app/core/domain/use_cases/image_watermark_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late ImageWatermarkUseCase useCase;

  setUp(() {
    useCase = ImageWatermarkUseCase(Mocks.phoneGalleryRepository);
  });

  test('should successfully return from repository when add watermark', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.addImageWatermark(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) => successFuture(''));

    // WHEN
    final result = await useCase.execute(path: '', username: '');

    // THEN
    expect(result.isSuccess, true);
    verify(
      () => Mocks.phoneGalleryRepository.addImageWatermark(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).called(1);
  });

  test('should fail from repository when add watermark fails', () async {
    // GIVEN
    when(
      () => Mocks.phoneGalleryRepository.addImageWatermark(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) => failFuture(const ImageWatermarkFailure.unknown()));

    // WHEN
    final result = await useCase.execute(path: '', username: '');

    // THEN
    expect(result.isFailure, true);
    verify(
      () => Mocks.phoneGalleryRepository.addImageWatermark(
        path: any(named: 'path'),
        username: any(named: 'username'),
      ),
    ).called(1);
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<ImageWatermarkUseCase>();
    expect(useCase, isNotNull);
  });
}

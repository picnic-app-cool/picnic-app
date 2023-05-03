import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/video_thumbnail_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late VideoThumbnailUseCase useCase;

  setUp(() {
    useCase = VideoThumbnailUseCase(
      Mocks.attachmentRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      final videoFile = File("video");
      const thumbnailPath = 'thumbnailPath';
      when(
        () => Mocks.attachmentRepository.getThumbnail(
          video: videoFile,
          maxHeight: 180,
          quality: 80,
        ),
      ).thenAnswer(
        (_) => successFuture(thumbnailPath),
      );

      // WHEN
      final result = await useCase.execute(
        video: videoFile,
        maxHeight: 180,
        quality: 80,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<VideoThumbnailUseCase>();
    expect(useCase, isNotNull);
  });
}

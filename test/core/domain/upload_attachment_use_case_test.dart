import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/upload_attachment_failure.dart';
import 'package:picnic_app/core/domain/use_cases/upload_attachment_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UploadAttachmentUseCase useCase;

  setUp(() {
    useCase = UploadAttachmentUseCase(
      Mocks.attachmentRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.attachmentRepository.uploadAttachment(attachment: any(named: "attachment"))).thenAnswer(
        (_) => successFuture(Stubs.attachment),
      );

      // WHEN
      final result = await useCase.execute(
        attachments: [Stubs.uploadAttachmentCorrect],
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case fails if one attachment fails',
    () async {
      // GIVEN
      when(() => Mocks.attachmentRepository.uploadAttachment(attachment: Stubs.uploadAttachmentCorrect)).thenAnswer(
        (_) => successFuture(Stubs.attachment),
      );

      when(() => Mocks.attachmentRepository.uploadAttachment(attachment: Stubs.uploadAttachmentBigSize)).thenAnswer(
        (_) => failFuture(const UploadAttachmentFailure.unknown()),
      );

      // WHEN
      final result = await useCase.execute(
        attachments: [Stubs.uploadAttachmentCorrect, Stubs.uploadAttachmentBigSize],
      );

      // THEN
      expect(result.isFailure, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UploadAttachmentUseCase>();
    expect(useCase, isNotNull);
  });
}

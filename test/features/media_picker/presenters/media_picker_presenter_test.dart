import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/media_picker_mock_definitions.dart';
import '../mocks/media_picker_mocks.dart';

void main() {
  late MediaPickerPresentationModel model;
  late MediaPickerPresenter presenter;
  late MockImageVideoPickerNavigator navigator;

  test(
    'onTapAttachment should successfully append attachment without showing too big size attachment dialog.',
    () async {
      // GIVEN
      const attachment = Attachment.empty();

      when(
        () => ChatMocks.getUploadChatAttachmentUseCase.execute(
          attachment: any(named: 'attachment'),
        ),
      ).thenAnswer((_) => successFuture(const UploadAttachment.empty()));

      // WHEN
      await presenter.onTapAttachment(attachment);

      // THEN
      verifyNever(() => navigator.showFileSizeTooBigError(maxAllowedSize: any(named: "maxAllowedSize")));
      expect(presenter.state.selectedAttachments.length, 1);
      expect(presenter.state.selectedAttachments.first.url, attachment.url);

      // WHEN
      presenter.onTapDeleteAttachment(attachment);

      // THEN
      expect(presenter.state.selectedAttachments.length, 0);
    },
  );

  test(
    'TooBigFileSize dialog should be shown when user picks attachment with size bigger than allowed. No attachment will be added',
    () async {
      // GIVEN
      const attachment = Attachment.empty();

      when(
        () => navigator.showFileSizeTooBigError(maxAllowedSize: any(named: "maxAllowedSize")),
      ).thenAnswer((_) => Future.value());

      when(
        () => ChatMocks.getUploadChatAttachmentUseCase.execute(
          attachment: any(named: 'attachment'),
        ),
      ).thenAnswer((_) => successFuture(Stubs.uploadAttachmentBigSize));

      // WHEN
      await presenter.onTapAttachment(attachment);

      // THEN
      verify(() => navigator.showFileSizeTooBigError(maxAllowedSize: any(named: "maxAllowedSize")));
      expect(presenter.state.selectedAttachments.length, 0);
    },
  );

  setUp(() {
    model = MediaPickerPresentationModel.initial(const MediaPickerInitialParams());
    navigator = MockImageVideoPickerNavigator();
    presenter = MediaPickerPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.videoThumbnailUseCase,
      Mocks.getAttachmentsUseCase,
      ChatMocks.getUploadChatAttachmentUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.appInfoStore,
    )..setMediator(MediaPickerMocks.mediaPickerMediator);
  });
}

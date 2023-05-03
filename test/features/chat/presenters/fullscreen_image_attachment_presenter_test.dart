import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_initial_params.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presentation_model.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/chat_mock_definitions.dart';

void main() {
  late FullscreenAttachmentPresentationModel model;
  late FullscreenAttachmentPresenter presenter;
  late MockFullscreenImageAttachmentNavigator navigator;

  test(
    'should navigate back',
    () async {
      // GIVEN
      when(() => navigator.close()).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapBack();

      // THEN
      verify(() => navigator.close());
    },
  );

  setUp(() {
    model = FullscreenAttachmentPresentationModel.initial(
      FullscreenAttachmentInitialParams(
        message: Stubs.chatMessageWithAttachment,
      ),
      Mocks.currentTimeProvider,
    );
    navigator = MockFullscreenImageAttachmentNavigator();
    presenter = FullscreenAttachmentPresenter(
      model,
      navigator,
    );
  });
}

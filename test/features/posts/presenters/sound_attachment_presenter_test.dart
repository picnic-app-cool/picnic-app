import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late SoundAttachmentPresentationModel model;
  late SoundAttachmentPresenter presenter;
  late MockSoundAttachmentNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = SoundAttachmentPresentationModel.initial(const SoundAttachmentInitialParams());
    navigator = MockSoundAttachmentNavigator();
    presenter = SoundAttachmentPresenter(
      model,
      navigator,
      PostsMocks.getSoundsListUseCase,
      Mocks.controlAudioPlayUseCase,
      Mocks.debouncer,
    );
  });
}

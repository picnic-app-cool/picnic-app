import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late PollPostCreationPresentationModel model;
  late PollPostCreationPresenter presenter;
  late MockPollPostCreationNavigator navigator;

  test('tapping new circle should open create circle successfully', () {
    when(
      () => navigator.openCreateCircle(any()),
    ).thenAnswer((_) => Future.value());

    presenter.onTapNewCircle();

    verify(() => navigator.openCreateCircle(any())).called(1);
  });

  group('sound attachments', () {
    test('tapping music should emit sound attachments successfully', () async {
      when(
        () => navigator.openSoundAttachment(const SoundAttachmentInitialParams()),
      ).thenAnswer((_) async => Stubs.sound1);

      await presenter.onTapMusic();

      verify(
        () => navigator.openSoundAttachment(const SoundAttachmentInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.sound, Stubs.sound1);
    });

    test('tapping music should not emit sound attachments', () async {
      when(
        () => navigator.openSoundAttachment(const SoundAttachmentInitialParams()),
      ).thenAnswer((_) async => null);

      await presenter.onTapMusic();

      verify(
        () => navigator.openSoundAttachment(const SoundAttachmentInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.sound, const Sound.empty());
    });

    test('tapping delete sound attachment should emit an empty sound', () {
      presenter.onTapDeleteSoundAttachment();
      expect(presenter.state.pollForm.sound, const Sound.empty());
    });
  });

  group('on tap image', () {
    final file = File('');

    test('tapping left image should emit the file path from image', () {
      when(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).thenAnswer((_) async => file);

      presenter.onTapLeftImage();

      verify(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.leftImagePath, file.path);
    });

    test('tapping left image should not emit the file path from image', () {
      when(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).thenAnswer((_) async => null);

      presenter.onTapLeftImage();

      verify(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.leftImagePath, '');
    });

    test('tapping right image should emit the file path from image', () {
      when(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).thenAnswer((_) async => file);

      presenter.onTapRightImage();

      verify(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.leftImagePath, file.path);
    });

    test('tapping right image should not emit the file path from image', () {
      when(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).thenAnswer((_) async => null);

      presenter.onTapRightImage();

      verify(
        () => navigator.openImagePicker(const ImagePickerInitialParams()),
      ).called(1);
      expect(presenter.state.pollForm.rightImagePath, '');
    });
  });

  test('changing question should call mention user use case', () async {
    // GIVEN
    when(
      () => Mocks.mentionUserUseCase.execute(
        query: any(named: 'query'),
        notifyMeta: const NotifyMeta.post(),
        ignoreAtSign: true,
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage([Stubs.userMention])),
    );

    // WHEN
    presenter.onChangedMention('');

    // THEN
    verify(
      () => Mocks.mentionUserUseCase.execute(
        query: any(named: 'query'),
        notifyMeta: const NotifyMeta.post(),
        ignoreAtSign: true,
      ),
    ).called(1);
  });

  test('tapping suggested mention should clear the list of suggestions', () async {
    // WHEN
    presenter.onTapSuggestedMention(Stubs.userMention);

    // THEN
    expect(
      presenter.state.suggestedUsersToMention,
      const PaginatedList.empty(),
    );
  });

  test('tapping suggested mention from left media image should clear the list of suggestions', () async {
    // WHEN
    presenter.onTapSuggestedMentionLeft(Stubs.userMention);

    // THEN
    expect(
      presenter.state.suggestedUsersToMention,
      const PaginatedList.empty(),
    );
  });

  test('tapping suggested mention from left media image should emit the profile correctly', () async {
    // WHEN
    presenter.onTapSuggestedMentionLeft(Stubs.userMention);

    // THEN
    expect(
      presenter.state.pollForm.leftMentionedUser,
      Stubs.userMention,
    );
  });

  test('tapping suggested mention from right media image should clear the list of suggestions', () async {
    // WHEN
    presenter.onTapSuggestedMentionRight(Stubs.userMention);

    // THEN
    expect(
      presenter.state.suggestedUsersToMention,
      const PaginatedList.empty(),
    );
  });

  test('tapping suggested mention from right media image should emit the profile correctly', () async {
    // WHEN
    presenter.onTapSuggestedMentionRight(Stubs.userMention);

    // THEN
    expect(
      presenter.state.pollForm.rightMentionedUser,
      Stubs.userMention,
    );
  });
  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = PollPostCreationPresentationModel.initial(
      PollPostCreationInitialParams(onTapPost: (_) {}),
      Mocks.featureFlagsStore,
    );
    navigator = MockPollPostCreationNavigator();
    presenter = PollPostCreationPresenter(
      model,
      navigator,
      Mocks.mentionUserUseCase,
    );
  });
}

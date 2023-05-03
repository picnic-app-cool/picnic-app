import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/use_cases/mention_user_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/poll_image_side.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';

class PollPostCreationPresenter extends Cubit<PollPostCreationViewModel> {
  PollPostCreationPresenter(
    PollPostCreationPresentationModel model,
    this.navigator,
    this._mentionUserUseCase,
  ) : super(model);

  final PollPostCreationNavigator navigator;
  final MentionUserUseCase _mentionUserUseCase;

  // ignore: unused_element
  PollPostCreationPresentationModel get _model => state as PollPostCreationPresentationModel;

  void onTapNewCircle() => navigator.openCreateCircle(
        CreateCircleInitialParams(createPostInput: _model.createPostInput),
      );

  void onChangedQuestion(String value) {
    tryEmit(
      _model.byUpdatingForm(
        (form) => form.copyWith(question: value),
      ),
    );

    _mentionUserUseCase
        .execute(
          query: value,
          notifyMeta: const NotifyMeta.post(),
        )
        .doOn(
          success: (result) => tryEmit(
            _model.copyWith(suggestedUsersToMention: result),
          ),
        );
  }

  void onChangedMention(String value) {
    _mentionUserUseCase
        .execute(
          query: value,
          notifyMeta: const NotifyMeta.post(),
          ignoreAtSign: true,
        )
        .doOn(
          success: (result) => tryEmit(
            _model.copyWith(
              suggestedUsersToMention: result,
            ),
          ),
        );
  }

  void onTapSuggestedMention(UserMention mentionedUser) => _clearSuggestedUsersToMention();

  void onTapSuggestedMentionLeft(UserMention mentionedUser) {
    _updateMentionedUser(
      side: PollImageSide.left,
      mentionedUser: mentionedUser,
    );

    _clearSuggestedUsersToMention();
  }

  void onTapSuggestedMentionRight(UserMention mentionedUser) {
    _updateMentionedUser(
      side: PollImageSide.right,
      mentionedUser: mentionedUser,
    );

    _clearSuggestedUsersToMention();
  }

  void onTapPost() => _model.onPostUpdatedCallback(_model.createPostInput);

  Future<void> onTapMusic() async {
    final sound = await navigator.openSoundAttachment(
      const SoundAttachmentInitialParams(),
    );
    if (sound != null) {
      tryEmit(
        _model.byUpdatingForm((form) => form.byAddingSound(sound)),
      );
    }
  }

  void onTapLeftImage() => _pickImage(PollImageSide.left);

  void onTapRightImage() => _pickImage(PollImageSide.right);

  void onTapDeleteSoundAttachment() => tryEmit(
        _model.byUpdatingForm((form) => form.byRemovingSound()),
      );

  Future<void> _pickImage(PollImageSide side) async {
    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image != null) {
      tryEmit(
        _model.byUpdatingForm(
          (form) => form.byUpdatingImage(
            side: side,
            path: image.path,
          ),
        ),
      );
    }
  }

  void _clearSuggestedUsersToMention() {
    tryEmit(
      _model.byUpdatingSuggestedUsersToMention(
        suggestedUsersToMention: const PaginatedList.empty(),
      ),
    );
  }

  void _updateMentionedUser({
    required PollImageSide side,
    required UserMention mentionedUser,
  }) {
    tryEmit(
      _model.byUpdatingForm(
        (form) => form.byUpdatingMentionedUser(
          side: side,
          userMention: mentionedUser,
        ),
      ),
    );
  }
}

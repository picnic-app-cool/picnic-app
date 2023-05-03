import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class TextPostCreationPresentationModel implements TextPostCreationViewModel {
  /// Creates the initial state
  TextPostCreationPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    TextPostCreationInitialParams initialParams,
    FeatureFlagsStore featureFlags,
  )   : selectedColor = TextPostColor.blue,
        text = '',
        featureFlags = featureFlags.featureFlags,
        onPostUpdatedCallback = initialParams.onTapPost,
        sound = const Sound.empty(),
        circle = initialParams.circle;

  /// Used for the copyWith method
  TextPostCreationPresentationModel._({
    required this.selectedColor,
    required this.text,
    required this.sound,
    required this.onPostUpdatedCallback,
    required this.featureFlags,
    required this.circle,
  });

  @override
  final TextPostColor selectedColor;

  @override
  final FeatureFlags featureFlags;

  final String text;

  @override
  final Sound sound;

  final Function(CreatePostInput) onPostUpdatedCallback;
  final Circle? circle;

  @override
  String get circleName => circle?.name ?? '';

  @override
  bool get postingEnabled => circle?.textPostingEnabled ?? true;

  CreatePostInput get createPostInput => CreatePostInput(
        circleId: const Id.empty(), // circle id is added in the last step
        content: TextPostContentInput(
          additionalText: '',
          text: text,
          color: selectedColor,
        ),
        sound: sound,
      );

  @override
  bool get postButtonEnabled => text.isNotEmpty;

  @override
  bool get showAddSoundButton =>
      sound == const Sound.empty() && featureFlags[FeatureFlagType.attachSoundsToPostsEnabled];

  @override
  bool get showSelectedSoundBadge =>
      sound != const Sound.empty() && featureFlags[FeatureFlagType.attachSoundsToPostsEnabled];

  TextPostCreationPresentationModel copyWith({
    TextPostColor? selectedColor,
    String? text,
    Sound? sound,
    FeatureFlags? featureFlags,
    Function(CreatePostInput)? onPostUpdatedCallback,
    Circle? circle,
  }) {
    return TextPostCreationPresentationModel._(
      selectedColor: selectedColor ?? this.selectedColor,
      text: text ?? this.text,
      sound: sound ?? this.sound,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      featureFlags: featureFlags ?? this.featureFlags,
      circle: circle ?? this.circle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class TextPostCreationViewModel {
  TextPostColor get selectedColor;

  bool get postButtonEnabled;

  bool get showAddSoundButton;

  bool get showSelectedSoundBadge;

  Sound get sound;

  FeatureFlags get featureFlags;

  bool get postingEnabled;

  String get circleName;
}

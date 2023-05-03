import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/posts/domain/model/playable_sound.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SoundAttachmentPresentationModel implements SoundAttachmentViewModel {
  /// Creates the initial state
  SoundAttachmentPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SoundAttachmentInitialParams initialParams,
  )   : textSearched = '',
        sounds = const PaginatedList.empty();

  /// Used for the copyWith method
  SoundAttachmentPresentationModel._({
    required this.textSearched,
    required this.sounds,
  });

  final String textSearched;

  @override
  final PaginatedList<PlayableSound> sounds;

  Cursor get cursor => sounds.nextPageCursor();

  SoundAttachmentPresentationModel byAppendingSoundsList(PaginatedList<Sound> newList) => copyWith(
        sounds: sounds +
            newList.mapItems(
              (sound) => sound.toPlayableSound(),
            ),
      );

  SoundAttachmentPresentationModel copyWith({
    String? textSearched,
    PaginatedList<PlayableSound>? sounds,
  }) {
    return SoundAttachmentPresentationModel._(
      textSearched: textSearched ?? this.textSearched,
      sounds: sounds ?? this.sounds,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SoundAttachmentViewModel {
  PaginatedList<PlayableSound> get sounds;
}

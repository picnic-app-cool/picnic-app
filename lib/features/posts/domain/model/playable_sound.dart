import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class PlayableSound extends Equatable {
  const PlayableSound({
    required this.sound,
    required this.isPlaying,
  });

  const PlayableSound.empty()
      : sound = const Sound.empty(),
        isPlaying = false;

  final Sound sound;
  final bool isPlaying;

  @override
  List<Object?> get props => [
        sound,
        isPlaying,
      ];

  PlayableSound copyWith({
    Sound? sound,
    bool? isPlaying,
  }) {
    return PlayableSound(
      sound: sound ?? this.sound,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

extension SoundToPlayable on Sound {
  PlayableSound toPlayableSound({bool isPlaying = false}) => PlayableSound(sound: this, isPlaying: isPlaying);
}

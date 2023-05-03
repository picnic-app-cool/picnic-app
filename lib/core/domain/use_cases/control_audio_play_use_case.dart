import 'package:picnic_app/core/domain/repositories/audio_player_repository.dart';

class ControlAudioPlayUseCase {
  const ControlAudioPlayUseCase(this._repository);

  final AudioPlayerRepository _repository;

  Future<void> execute({
    required AudioAction action,
    String? soundUrl,
  }) async {
    switch (action) {
      case AudioAction.play:
        if (soundUrl != null) {
          return _repository.play(soundUrl);
        }
        return;
      case AudioAction.pause:
        return _repository.pause();
      case AudioAction.resume:
        return _repository.resume();
      case AudioAction.stop:
        return _repository.stop();
    }
  }
}

enum AudioAction {
  play,
  pause,
  resume,
  stop,
}

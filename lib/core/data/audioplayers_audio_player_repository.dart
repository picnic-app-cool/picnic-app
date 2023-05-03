import 'package:audioplayers/audioplayers.dart';
import 'package:picnic_app/core/domain/repositories/audio_player_repository.dart';

class AudioPlayersAudioPlayerRepository implements AudioPlayerRepository {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> play(String url) async {
    await stop();
    return _player.play(UrlSource(url));
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> resume() => _player.resume();

  @override
  Future<void> stop() => _player.stop();
}

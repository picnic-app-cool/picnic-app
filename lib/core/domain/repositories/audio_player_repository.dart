abstract class AudioPlayerRepository {
  Future<void> play(String url);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
}

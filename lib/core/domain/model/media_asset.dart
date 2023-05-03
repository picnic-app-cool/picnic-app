abstract class MediaAsset {
  bool get isPhoto;

  bool get isVideo;

  Future<String?> get filePath;
}

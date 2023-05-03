enum MediaPickerFileType {
  image,
  video,
  document;

  String get mimeType {
    switch (this) {
      case MediaPickerFileType.image:
        return "image";
      case MediaPickerFileType.video:
        return "video";
      case MediaPickerFileType.document:
        return "application/pdf";
    }
  }
}

//ignore_for_file: unused-code, unused-files, no-magic-number
/// Upload file size limit in bytes.
enum UploadFileSize {
  profileImage._(sizeInMegabytes: 30),
  //TODO should be increased to 300 when BE reaedy https://picnic-app.atlassian.net/browse/GS-7490
  videoPostContent._(sizeInMegabytes: 100),
  imagePostContent._(sizeInMegabytes: 30),
  chatImageContent._(sizeInMegabytes: 30),
  chatVideoContent._(sizeInMegabytes: 30),
  sliceImage._(sizeInMegabytes: 30),
  documentContent._(sizeInMegabytes: 30),
  circleImage._(sizeInMegabytes: 30);

  const UploadFileSize._({
    required this.sizeInMegabytes,
  });

  static const codersThousand = 1024;
  final int sizeInMegabytes;

  int get size => _toBytes(sizeInMegabytes);

  static int _toBytes(int megabytes) => megabytes * codersThousand * codersThousand;
}

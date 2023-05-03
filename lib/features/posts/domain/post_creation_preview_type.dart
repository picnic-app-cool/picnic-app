// ignore_for_file: no-magic-number
import 'package:picnic_app/localization/app_localizations_utils.dart';

enum PostCreationPreviewType {
  link,
  image(
    fullscreen: true,
    darkBackground: true,
  ),
  video(
    fullscreen: true,
    darkBackground: true,
  ),
  poll,
  text;

  final bool fullscreen;
  final bool darkBackground;

  String get label {
    switch (this) {
      case PostCreationPreviewType.link:
        return appLocalizations.linkTabAction;
      case PostCreationPreviewType.image:
        return appLocalizations.photoTabAction;
      case PostCreationPreviewType.video:
        return appLocalizations.videoTabAction;
      case PostCreationPreviewType.poll:
        return appLocalizations.pollTabAction;
      case PostCreationPreviewType.text:
        return appLocalizations.thoughtTabAction;
    }
  }

  const PostCreationPreviewType({
    this.fullscreen = false,
    this.darkBackground = false,
  });
}

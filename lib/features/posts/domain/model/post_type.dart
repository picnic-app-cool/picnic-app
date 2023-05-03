import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';

enum PostType {
  text('TEXT'),
  image('IMAGE'),
  video('VIDEO'),
  link('LINK'),
  poll('POLL'),
  unknown('UNKNOWN');

  final String value;

  const PostType(this.value);

  static PostType fromString(String value) => PostType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => PostType.unknown,
      );

  PostOverlayTheme get overlayTheme {
    switch (this) {
      case PostType.text:
        return PostOverlayTheme.dark;
      case PostType.image:
        return PostOverlayTheme.light;
      case PostType.video:
        return PostOverlayTheme.light;
      case PostType.link:
        return PostOverlayTheme.dark;
      case PostType.poll:
        return PostOverlayTheme.dark;
      case PostType.unknown:
        return PostOverlayTheme.dark;
    }
  }
}

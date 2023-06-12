import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';

class PostBarUserAvatarButtonParams {
  const PostBarUserAvatarButtonParams({
    required this.iFollow,
    required this.userAvatar,
    required this.onTapAvatar,
    required this.onTapFollow,
    required this.overlayTheme,
  });

  final bool iFollow;
  final String userAvatar;
  final VoidCallback onTapAvatar;
  final VoidCallback onTapFollow;
  final PostOverlayTheme overlayTheme;
}

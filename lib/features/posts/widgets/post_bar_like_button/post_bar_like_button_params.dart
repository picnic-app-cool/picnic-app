import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';

class PostBarLikeButtonParams {
  const PostBarLikeButtonParams({
    required this.isLiked,
    required this.likes,
    required this.overlayTheme,
    required this.onTap,
    this.isVertical = true,
    this.width,
  });

  final bool isLiked;
  final String likes;
  final PostOverlayTheme overlayTheme;
  final VoidCallback onTap;
  final bool isVertical;
  final double? width;
}

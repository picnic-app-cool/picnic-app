import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/link_post/widgets/link_placeholder.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicLinkPost extends StatelessWidget {
  const PicnicLinkPost({
    Key? key,
    required this.linkMetadata,
    required this.onTap,
    required this.linkUrl,
    this.height,
    this.onDoubleTap,
    this.withRoundedCorners = true,
  }) : super(key: key);

  final LinkMetadata linkMetadata;
  final double? height;
  final LinkUrl linkUrl;
  final ValueChanged<LinkUrl> onTap;
  final VoidCallback? onDoubleTap;
  final bool withRoundedCorners;

  static const _titleMaxLines = 2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final black = colors.blackAndWhite.shade900;
    final white = colors.blackAndWhite.shade100;
    final whiteWithOpacity = white.withOpacity(0.7);
    final defaultHeight = height ?? MediaQuery.of(context).size.height / 2;
    final borderRadius = withRoundedCorners ? BorderRadius.circular(24) : BorderRadius.zero;
    final image = Stack(
      children: [
        PicnicImage(
          source: PicnicImageSource.imageUrl(
            linkMetadata.imageUrl,
            width: double.infinity,
            height: defaultHeight,
            fit: BoxFit.cover,
          ),
          placeholder: () => LinkPlaceholder(
            linkUrl: linkUrl,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: _gradient(black),
            ),
          ),
        ),
      ],
    );
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => onTap(linkUrl),
      onDoubleTap: onDoubleTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            image,
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 20.0,
                  right: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      linkMetadata.title,
                      maxLines: _titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                      style: theme.styles.title20.copyWith(color: white),
                    ),
                    Text(
                      linkMetadata.host,
                      style: theme.styles.caption10.copyWith(color: whiteWithOpacity),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _gradient(Color color) {
    final colorWithOpacity20 = color.withOpacity(0.2);
    final colorWithOpacity0 = color.withOpacity(0.0);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity20,
      ],
    );
  }
}

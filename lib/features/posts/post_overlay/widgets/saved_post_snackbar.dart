import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SavedPostSnackBar extends StatelessWidget {
  const SavedPostSnackBar({
    required this.post,
    required this.onTap,
    super.key,
  });

  final Post post;
  final GestureTapCallback onTap;

  static const _opacity = 0.16;
  static const _blurRadius = 40.0;
  static const _borderRadius = 100.0;
  static const _imageBorderRadius = 12.0;
  static const _imageSizeDimension = 32.0;

  ImageUrl get _imageUrl {
    final content = post.content;
    if (content is ImagePostContent) {
      return content.imageUrl;
    }
    if (content is VideoPostContent) {
      return content.thumbnailUrl;
    }
    return const ImageUrl.empty();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final imageIsNotEmpty = _imageUrl.url.isNotEmpty;
    final bottomNavigationSize = BottomNavigationSizeQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalMargin = constraints.maxWidth * 0.15;

        return InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              bottom: bottomNavigationSize.height,
            ),
            decoration: BoxDecoration(
              color: colors.blackAndWhite.shade100,
              boxShadow: [
                BoxShadow(
                  color: colors.blackAndWhite.withOpacity(_opacity),
                  offset: const Offset(0, 4),
                  blurRadius: _blurRadius,
                ),
              ],
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              24,
              12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageIsNotEmpty)
                  SizedBox.square(
                    dimension: _imageSizeDimension,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_imageBorderRadius),
                      child: PicnicImage(
                        source: PicnicImageSource.imageUrl(
                          _imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (imageIsNotEmpty) const Gap(10),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        appLocalizations.tapToSelectCollection,
                        style: styles.body20.copyWith(
                          color: colors.blue,
                        ),
                      ),
                      Text(
                        appLocalizations.savedToGeneral,
                        style: styles.caption10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

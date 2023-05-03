import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/double_tap_detector.dart';
import 'package:picnic_app/ui/widgets/picnic_post/horizontal_post.dart';
import 'package:picnic_app/ui/widgets/picnic_post/vertical_post.dart';
import 'package:picnic_app/utils/extensions/post_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// Customizable [PicnicPost]
///
/// The Picnic App has 3 post [dimension]s , [PicnicPostDimension.horizontal], [PicnicPostDimension.vertical] and [PicnicPostDimension.verticalGallery]
///
///[PicnicPostDimension.verticalGallery] being a post that has two halved background images
///
///[background] serves as the single background for posts [PicnicPostDimension.horizontal], [PicnicPostDimension.vertical], while it also serves as the left half of [PicnicPostDimension.verticalGallery]
///
/// [backgroundRightHalf] is optional for a [PicnicPost] as it is only necessary for the right half of [PicnicPostDimension.verticalGallery]
///
/// [addBackgroundShadow] used to overlay a 'tint' on images

class PicnicPost extends StatelessWidget {
  const PicnicPost({
    Key? key,
    required this.background,
    this.bodyText = "",
    required this.post,
    this.onTapExpand,
    this.onTapCircleTag,
    this.dimension = PicnicPostDimension.horizontal,
    this.backgroundRightHalf,
    this.addBackgroundShadow = true,
    this.subTitle,
    this.title = "",
    this.height = verticalHeight,
    this.postSummaryBar,
    this.onDoubleTap,
    this.shouldExpand = false,
  }) : super(key: key);

  final BoxDecoration background;

  final BoxDecoration? backgroundRightHalf;

  final String bodyText;
  final String title;
  final String? subTitle;
  final Widget? postSummaryBar;

  final Post post;

  final VoidCallback? onTapExpand;
  final VoidCallback? onTapCircleTag;
  final VoidCallback? onDoubleTap;
  final PicnicPostDimension dimension;
  final bool addBackgroundShadow;
  final double height;
  final bool shouldExpand;

  /// The width and height of a [PicnicPostDimension.vertical] and [PicnicPostDimension.verticalGallery]
  static const verticalHeight = 230.0;
  static const verticalWidth = 162.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final picnicPostContainer = Container(
      height: dimension == PicnicPostDimension.vertical
          ? height
          : dimension == PicnicPostDimension.verticalGallery
              ? height
              : null,
      width: dimension == PicnicPostDimension.horizontal ? double.infinity : verticalWidth,
      decoration: dimension != PicnicPostDimension.verticalGallery ? background : null,
      child: dimension == PicnicPostDimension.horizontal
          ? HorizontalPost(
              colors: colors,
              styles: styles,
              bodyText: bodyText,
              onTapExpand: onTapExpand,
              postSummaryBar: postSummaryBar,
            )
          : VerticalPost(
              dimension: dimension,
              colors: colors,
              subTitle: subTitle,
              styles: styles,
              bodyText: bodyText,
              title: title.formattedPostTitle,
              width: verticalWidth,
              background: background,
              backgroundRightHalf: backgroundRightHalf,
              postSummaryBar: postSummaryBar,
              height: height,
              addBackgroundShadow: addBackgroundShadow,
            ),
    );

    // Dynamically change height of Post Container , unless dimension == PicnicPostDimension.vertical or dimension == PicnicPostDimension.verticalGallery
    return DoubleTapDetector(
      onDoubleTap: () => onDoubleTap?.call(),
      child: shouldExpand
          ? picnicPostContainer
          : Align(
              heightFactor: 1,
              child: picnicPostContainer,
            ),
    );
  }
}

enum PicnicPostDimension { horizontal, vertical, verticalGallery }

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_tag_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_styles.dart';

class VerticalPost extends StatelessWidget {
  const VerticalPost({
    required this.width,
    required this.background,
    required this.backgroundRightHalf,
    required this.postSummaryBar,
    required this.bodyText,
    required this.styles,
    required this.dimension,
    required this.height,
    required this.addBackgroundShadow,
    required this.colors,
    this.subTitle,
    this.title = "",
  });

  /// Serves as a single background image OR the left photo in the [PicnicPostDimension.verticalGallery]
  final BoxDecoration background;

  final BoxDecoration? backgroundRightHalf;
  final String bodyText;
  final String? subTitle;
  final String title;

  final PicnicStyles styles;
  final PicnicColors colors;
  final PicnicPostDimension dimension;
  final bool addBackgroundShadow;

  final double width;

  final double height;

  final Widget? postSummaryBar;

  /// The position of the [PicnicBarWithTagAvatar] in the stack
  static const _picnicBarWithAvatarPadding = 10.0;

  /// The max lines of [bodyText] [title] in the [VerticalPost] until an ellipsis (..) is given
  static const _maxLines = 6;

  @override
  Widget build(BuildContext context) {
    final white = colors.blackAndWhite.shade100;
    final black = colors.blackAndWhite.shade900;
    final blackWithOpacity20 = black.withOpacity(0.2);

    final widthCalculated = (width / 2) - 0.5;
    final blackWithOpacity30 = black.withOpacity(0.3);
    final blackWithOpacity70 = black.withOpacity(0.7);
    final shadowContainer = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blackWithOpacity20,
            blackWithOpacity20,
            blackWithOpacity30,
            blackWithOpacity70,
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
    );

    final caption30White = styles.caption30.copyWith(
      color: white,
    );
    return Stack(
      children: [
        if (dimension == PicnicPostDimension.verticalGallery)
          Row(
            children: [
              Container(
                width: widthCalculated,
                height: height,
                decoration: background,
              ),
              const Gap(1),
              Container(
                width: widthCalculated,
                height: height,
                decoration: backgroundRightHalf,
              ),
            ],
          ),
        if (addBackgroundShadow) shadowContainer,
        if (dimension == PicnicPostDimension.vertical)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 16.0,
                  left: 16.5,
                  bottom: 5.0,
                ),
                child: bodyText.isNotEmpty
                    ? Text(
                        bodyText,
                        maxLines: _maxLines,
                        style: caption30White,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        title,
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                        style: caption30White,
                      ),
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.5,
                  ),
                  child: Text(
                    subTitle!,
                    style: styles.caption10.copyWith(
                      color: white.withOpacity(Constants.opacityWhiteValue),
                    ),
                  ),
                ),
            ],
          ),
        if (postSummaryBar != null)
          Positioned(
            bottom: _picnicBarWithAvatarPadding,
            left: _picnicBarWithAvatarPadding,
            right: _picnicBarWithAvatarPadding,
            child: postSummaryBar!,
          ),
      ],
    );
  }
}

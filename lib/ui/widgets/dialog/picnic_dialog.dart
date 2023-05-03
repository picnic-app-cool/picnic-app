import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_description.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicDialog extends StatelessWidget {
  const PicnicDialog({
    Key? key,
    this.image,
    this.title,
    this.description,
    this.content,
    this.height,
    this.titleSize = PicnicDialogTitleSize.normal,
    this.imageStyle = PicnicDialogImageStyle.inside,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.radius = _dialogBorderRadius,
    this.margin = _marginOutsideContent,
    this.dialogPadding = _dialogPadding,
    this.contentPadding = _contentVerticalPadding,
    this.imageSpacing = _imageInsideSeparator,
    this.titleSpacing = 0,
    this.showShadow = true,

    ///this.reverse = true is needed so that the dialog is always scrolled to the bottom when keyboard appears,
    /// so the content below textfields is not cut off (on bottom we mostly have buttons which are important
    ///
    this.reverse = true,
  }) : super(key: key);

  /// Image widget to show on top
  final Widget? image;
  final String? title;
  final String? description;
  final Widget? content;
  final double? height;
  final double radius;
  final PicnicDialogTitleSize titleSize;
  final PicnicDialogImageStyle imageStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final EdgeInsets? margin;
  final EdgeInsets dialogPadding;
  final double contentPadding;
  final double? imageSpacing;
  final double titleSpacing;
  final bool showShadow;
  final bool reverse;

  /// The border radius of [PicnicDialog] component.
  static const _dialogBorderRadius = 40.0;

  /// The blur radius applied to box shadow of [PicnicDialog] component.
  static const _dialogBlurRadius = 40.0;

  /// The shadow opacity applied to box shadow of [PicnicDialog] component.
  static const _dialogShadowOpacity = 0.14;

  /// The padding of [PicnicDialog] component.
  static const _dialogPadding = EdgeInsets.only(
    top: 26,
    bottom: 24,
    left: 20,
    right: 20,
  );

  /// The top offset for image of [PicnicDialog] component.
  /// Ignored if `imageStyle` is [PicnicDialogImageStyle.inside].
  static const _imageOffsetTop = -72.0;

  /// The height of the `image` separator when
  /// `imageStyle` is [PicnicDialogImageStyle.inside].
  static const _imageInsideSeparator = 20.0;

  /// The height of the `image` separator when
  /// `imageStyle` is [PicnicDialogImageStyle.outside].
  static const _imageOutSideSeparator = 54.0;

  /// Outside padding from dialog borders
  static const _marginOutsideContent = EdgeInsets.all(24);

  /// Default vertical content padding if content exist
  static const _contentVerticalPadding = 35.0;

  @override
  Widget build(BuildContext context) {
    final imageInside = imageStyle == PicnicDialogImageStyle.inside;
    final imageExists = image != null;
    final titleExists = title != null;
    final descriptionExists = description != null;
    final contentExists = content != null;
    final theme = PicnicTheme.of(context);

    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      padding: dialogPadding,
      decoration: showShadow
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  blurRadius: _dialogBlurRadius,
                  color: theme.colors.blackAndWhite.shade900.withOpacity(_dialogShadowOpacity),
                  offset: const Offset(0, 20),
                ),
              ],
            )
          : null,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (!imageInside && imageExists)
            Positioned(
              top: _imageOffsetTop,
              child: image!,
            ),
          SingleChildScrollView(
            reverse: reverse,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imageInside && imageExists) image!,
                if (imageExists)
                  SizedBox(
                    height: imageInside ? imageSpacing : _imageOutSideSeparator,
                  ),
                if (titleExists) ...[
                  PicnicDialogTitle(
                    textStyle: titleTextStyle,
                    text: title!,
                    size: titleSize,
                  ),
                  Gap(titleSpacing),
                ],
                if (descriptionExists)
                  PicnicDialogDescription(
                    textStyle: descriptionTextStyle,
                    text: description!,
                  ),
                if (contentExists) ...[
                  Gap(contentPadding),
                  content!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum PicnicDialogImageStyle { inside, outside }

import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicLikeButton extends StatefulWidget {
  const PicnicLikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
    required this.size,
    required this.image,
    this.strokeColor,
    this.padding = EdgeInsets.zero,
    this.decoration,
  }) : super(key: key);

  final bool isLiked;
  final double size;
  final EdgeInsets padding;
  final Color? strokeColor;
  final VoidCallback? onTap;
  final AssetGenImage image;
  final BoxDecoration? decoration;

  @override
  State<PicnicLikeButton> createState() => _PicnicLikeButtonState();
}

class _PicnicLikeButtonState extends State<PicnicLikeButton> with TickerProviderStateMixin {
  @override
  void didUpdateWidget(PicnicLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLiked == oldWidget.isLiked) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: widget.decoration,
        child: (widget.isLiked ? Assets.images.likeFilled : widget.image).image(
          fit: BoxFit.cover,
          color: widget.isLiked
              ? colors.green.shade600
              : widget.strokeColor ??
                  (widget.image == Assets.images.likeFilled ? colors.blackAndWhite.shade100 : colors.darkBlue.shade600),
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}

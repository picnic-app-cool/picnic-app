import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/media_picker/widgets/media_preview.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MediaGridItem extends StatelessWidget {
  const MediaGridItem({
    required this.attachment,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final Attachment attachment;
  final bool isSelected;
  final VoidCallback onTap;

  static const _selectedOpacity = 0.4;
  static const double _iconSize = 20;
  static const double _roundedIconMargin = 10;
  static const double _roundedBackgroundOpacity = 0.9;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final white = colors.blackAndWhite.shade100.withOpacity(_roundedBackgroundOpacity);
    final black = colors.blackAndWhite.shade900;
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MediaPreview(attachment: attachment),
          if (isSelected) ...[
            Container(
              color: black.withOpacity(_selectedOpacity),
            ),
            Positioned(
              top: _roundedIconMargin,
              right: _roundedIconMargin,
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.check,
                  color: black,
                  size: _iconSize,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

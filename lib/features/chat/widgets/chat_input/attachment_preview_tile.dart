import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/attachments_horizontal_panel.dart';
import 'package:picnic_app/features/media_picker/widgets/media_preview.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class AttachmentPreviewTile extends StatelessWidget {
  const AttachmentPreviewTile({
    required this.attachment,
    required this.onTapDelete,
    super.key,
  });

  final Attachment attachment;
  final VoidCallback onTapDelete;

  static const _defaultBorderRadius = 12.0;
  static const _attachmentSize = AttachmentsHorizontalPanel.height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(_defaultBorderRadius)),
      child: SizedBox(
        height: _attachmentSize,
        width: _attachmentSize,
        child: Stack(
          children: [
            MediaPreview(attachment: attachment),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: onTapDelete,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    Assets.images.closeCircleTransparent.path,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

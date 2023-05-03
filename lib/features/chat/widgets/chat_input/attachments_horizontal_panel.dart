import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/attachment_preview_tile.dart';

class AttachmentsHorizontalPanel extends StatelessWidget {
  const AttachmentsHorizontalPanel({
    required this.attachments,
    required this.onTapDeleteAttachment,
    super.key,
  });

  final List<Attachment> attachments;
  final ValueChanged<Attachment> onTapDeleteAttachment;

  static const height = 90.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        separatorBuilder: (_, __) => const Gap(8),
        itemBuilder: (context, index) {
          final attachment = attachments[index];
          return AttachmentPreviewTile(
            attachment: attachment,
            onTapDelete: () => onTapDeleteAttachment(attachment),
          );
        },
      ),
    );
  }
}

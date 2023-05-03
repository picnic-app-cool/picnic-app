import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/attachments_grid.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/more_attachments_indicator.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/ui/widgets/picnic_blurred_attachment.dart';

class ChatMessageContentAttachments extends StatelessWidget {
  const ChatMessageContentAttachments({
    required this.message,
    required this.chatStyle,
    required this.onTapUnblur,
    required this.onTapAttachment,
  });

  final ChatMessage message;
  final PicnicChatStyle chatStyle;
  final Function(Attachment) onTapUnblur;
  final VoidCallback onTapAttachment;

  List<Attachment> get attachments => message.attachments;

  @override
  Widget build(BuildContext context) {
    return AttachmentsGrid(
      attachments: attachments,
      itemBuilder: (_, index) {
        final attachment = attachments[index];
        return MoreAttachmentsIndicator(
          attachmentsCount: attachments.length,
          index: index,
          child: PicnicBlurredAttachment(
            attachment: attachment,
            heroTag: message.id,
            onTapUnblur: onTapUnblur,
            onTapAttachment: onTapAttachment,
          ),
        );
      },
    );
  }
}

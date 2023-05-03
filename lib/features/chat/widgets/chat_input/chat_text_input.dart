import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/attachments_horizontal_panel.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatTextInput extends StatelessWidget {
  const ChatTextInput({
    Key? key,
    required this.onEditingComplete,
    this.textController,
    this.onChanged,
    this.fillColor,
    this.textColor,
    this.focusNode,
    required this.hintText,
    required this.attachments,
    required this.onTapDeleteAttachment,
    this.maxLines = _defaultMaxLines,
  }) : super(key: key);

  final String hintText;
  final TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? textColor;
  final FocusNode? focusNode;
  final int? maxLines;
  final List<Attachment> attachments;
  final ValueChanged<Attachment> onTapDeleteAttachment;
  final VoidCallback onEditingComplete;

  static const _defaultBorderRadius = 12.0;
  static const _defaultMaxLines = 5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyle = theme.styles.body10.copyWith(
      color: textColor ?? theme.colors.blackAndWhite.shade100,
    );

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(_defaultBorderRadius)),
      child: Container(
        color: fillColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (attachments.isNotEmpty) ...[
              const Gap(8),
              AttachmentsHorizontalPanel(
                attachments: attachments,
                onTapDeleteAttachment: onTapDeleteAttachment,
              ),
            ],
            TextFormField(
              focusNode: focusNode,
              controller: textController,
              onChanged: onChanged,
              style: textStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: hintText,
                hintStyle: textStyle,
              ),
              minLines: 1,
              maxLines: maxLines,
              textInputAction: TextInputAction.send,
              onEditingComplete: onEditingComplete,
            ),
          ],
        ),
      ),
    );
  }
}

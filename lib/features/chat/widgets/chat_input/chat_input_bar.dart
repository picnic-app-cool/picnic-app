import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/chat_text_input.dart';
import 'package:picnic_app/features/chat/widgets/chat_mentions/chat_suggestions_composer.dart';
import 'package:picnic_app/features/chat/widgets/chat_reply_message.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_rich_text_controller.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

///[ChatInputBar]
///
/// [isReplying] , [onTapCloseReply], [replyMessage] are optional. Used in the case of replying to a message

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    required this.onMessageUpdated,
    required this.sendMessageColor,
    this.attachmentIconColor,
    this.onTapSendMessage,
    this.onTapAddAttachment,
    this.onTapElectric,
    this.onTapCloseReply,
    this.isReplying = false,
    this.replyMessage,
    this.focusNode,
    this.additionalBottomPadding,
    required this.attachments,
    required this.onTapDeleteAttachment,
    this.suggestedUsersToMention = const PaginatedList.empty(),
    this.usersToMention = const PaginatedList.empty(),
    this.pendingMessage,
    this.onTapSuggestedMention,
    this.onMentionChanged,
    Key? key,
  }) : super(key: key);

  final bool isReplying;
  final Color sendMessageColor;
  final Color? attachmentIconColor;
  final VoidCallback? onTapSendMessage;
  final VoidCallback? onTapElectric;
  final VoidCallback? onTapCloseReply;
  final ChatMessage? replyMessage;
  final ChatMessage? pendingMessage;
  final VoidCallback? onTapAddAttachment;
  final ValueChanged<String>? onMessageUpdated;
  final List<Attachment> attachments;
  final ValueChanged<Attachment> onTapDeleteAttachment;
  final FocusNode? focusNode;
  final double? additionalBottomPadding;
  final PaginatedList<UserMention> suggestedUsersToMention;
  final PaginatedList<UserMention> usersToMention;
  final ValueChanged<UserMention>? onTapSuggestedMention;
  final ValueChanged<List<String>>? onMentionChanged;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late PicnicRichTextController _textEditingController;

  static const _newMessageInputOpacity = 0.05;
  static const _iconButtonSize = 40.0;
  static const _defaultRadius = 40.0;
  static const double _disabledOpacity = 0.4;

  static const _horizontalPadding = 20.0;
  static const _verticalPadding = 15.0;

  static const _borderRadius = BorderRadius.vertical(
    top: Radius.circular(_defaultRadius),
  );

  @override
  void initState() {
    super.initState();
    _textEditingController = PicnicRichTextController(
      onMatchChanged: _onMatchChanged,
    );
    _updateControllerMatcher();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.usersToMention != oldWidget.usersToMention) &&
        (widget.pendingMessage?.content != oldWidget.pendingMessage?.content)) {
      _updateControllerMatcher();
      _updateControllerText();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final blueShade = theme.colors.blue.shade800;

    final attachmentButton = PicnicContainerIconButton(
      iconPath: Assets.images.paperClip.path,
      onTap: widget.onTapAddAttachment,
      iconTintColor: widget.attachmentIconColor ?? blackAndWhite.shade600,
      buttonColor: Colors.transparent,
    );

    final electricButton = PicnicContainerIconButton(
      iconPath: Assets.images.electric.path,
      onTap: widget.onTapElectric,
      iconTintColor: blackAndWhite.shade600,
      buttonColor: Colors.transparent,
    );

    return ClipRRect(
      borderRadius: _borderRadius,
      child: Container(
        padding: EdgeInsets.only(
          top: _verticalPadding,
          bottom: _verticalPadding + (widget.additionalBottomPadding ?? 0.0),
          left: _horizontalPadding,
          right: _horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: blackAndWhite.shade100,
          borderRadius: _borderRadius,
          border: Border.all(color: blackAndWhite.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isReplying) ...[
              ChatReplyMessage(
                message: widget.replyMessage!,
                onTapCancelReply: widget.onTapCloseReply!,
              ),
              const Gap(12),
            ],
            ChatSuggestionsComposer(
              textEditingController: _textEditingController,
              suggestedUsersToMention: widget.suggestedUsersToMention,
              onTapSuggestedMention: widget.onTapSuggestedMention,
              child: Row(
                children: [
                  Row(
                    children: [
                      if (widget.onTapAddAttachment != null) attachmentButton,
                      if (widget.onTapElectric != null) electricButton,
                    ],
                  ),
                  Expanded(
                    child: ChatTextInput(
                      onChanged: widget.onMessageUpdated,
                      hintText: appLocalizations.chatNewMessageInputHint,
                      fillColor: blueShade.withOpacity(
                        _newMessageInputOpacity,
                      ),
                      textController: _textEditingController,
                      textColor: blackAndWhite.shade600,
                      focusNode: widget.focusNode,
                      attachments: widget.attachments,
                      onTapDeleteAttachment: widget.onTapDeleteAttachment,
                      onEditingComplete: _onEditingComplete,
                    ),
                  ),
                  const Gap(8),
                  PicnicIconButton(
                    size: _iconButtonSize,
                    icon: Assets.images.send.path,
                    color: widget.sendMessageColor.withOpacity(
                      widget.onTapSendMessage != null ? 1 : _disabledOpacity,
                    ),
                    onTap: _onEditingComplete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEditingComplete() {
    _textEditingController.clear();
    widget.onTapSendMessage?.call();
  }

  void _updateControllerMatcher() {
    final blueColor = PicnicTheme.of(context).colors.blue.shade600;
    final matcher = {
      for (final item in widget.usersToMention.items) item.name.formattedUsername: TextStyle(color: blueColor),
    };
    _textEditingController.textStyleMatcher = matcher;
  }

  void _updateControllerText() {
    _textEditingController.text = widget.pendingMessage?.content ?? '';
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _textEditingController.text.length,
      ),
    );
  }

  void _onMatchChanged(List<String> mentions) {
    _updateControllerMatcher();
    widget.onMentionChanged?.call(mentions);
  }
}

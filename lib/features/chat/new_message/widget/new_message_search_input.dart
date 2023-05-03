import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/new_message/widget/new_message_embedded_input.dart';
import 'package:picnic_app/features/chat/new_message/widget/new_message_recipient_tags.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NewMessageSearchInput extends StatelessWidget {
  const NewMessageSearchInput({
    Key? key,
    required this.recipients,
    required this.focusNode,
    required this.onChangedSearchText,
    required this.onTapRemoveRecipient,
    required this.textEditingController,
    this.showSelectedRecipients = false,
  }) : super(key: key);

  final List<User> recipients;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChangedSearchText;
  final ValueChanged<User> onTapRemoveRecipient;
  final bool showSelectedRecipients;

  static const _defaultRadius = 16.0;

  static const _inputPadding = EdgeInsets.only(
    top: 8.0,
    left: 32.0,
    right: 32.0,
    bottom: 16.0,
  );

  static const _defaultContentPadding = EdgeInsets.only(
    top: 16.0,
    right: 12.0,
    bottom: 16.0,
    left: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final green = theme.colors.green;
    final blackAndWhite = theme.colors.blackAndWhite;

    final textStyleBody20 = theme.styles.body20;

    final userTyping = focusNode.hasPrimaryFocus && textEditingController.text.isNotEmpty;

    final embeddedInput = NewMessageEmbeddedInput(
      focusNode: focusNode,
      onChangedSearchText: onChangedSearchText,
      textEditingController: textEditingController,
      showSelectedRecipients: showSelectedRecipients,
    );

    final recipientTags = NewMessageRecipientTags(
      recipients: recipients,
      onTapRemoveRecipient: onTapRemoveRecipient,
      lastChild: IntrinsicWidth(child: embeddedInput),
    );

    final personIconSuffix = Image.asset(
      Assets.images.personOutline.path,
      color: green,
    );

    return Padding(
      padding: _inputPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.chatNewMessageSearchInputLabelText,
            style: textStyleBody20.copyWith(
              color: userTyping ? green : blackAndWhite.shade700,
            ),
          ),
          const Gap(3),
          GestureDetector(
            onTap: focusNode.requestFocus,
            child: Container(
              decoration: BoxDecoration(
                color: userTyping ? blackAndWhite.shade100 : blackAndWhite.shade200,
                border: Border.all(
                  color: focusNode.hasFocus ? green : blackAndWhite.shade100,
                ),
                borderRadius: BorderRadius.circular(_defaultRadius),
              ),
              child: Padding(
                padding: _defaultContentPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    recipientTags,
                    personIconSuffix,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

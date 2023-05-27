import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NewMessageRecipientTags extends StatelessWidget {
  const NewMessageRecipientTags({
    Key? key,
    required this.recipients,
    required this.onTapRemoveRecipient,
    required this.lastChild,
  }) : super(key: key);

  final List<User> recipients;
  final Function(User) onTapRemoveRecipient;
  final Widget lastChild;

  static const _tagSpacing = 8.0;
  static const _tagBorderRadius = 100.0;
  static const _tagPadding = EdgeInsets.only(
    left: 10.0,
    right: 10.0,
    top: 4.0,
    bottom: 4.0,
  );
  static const _removeRecipientTagButtonPadding = EdgeInsets.all(2);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final picnicTags = recipients.map(
      (recipient) {
        final removeTagButton = ElevatedButton(
          onPressed: () => onTapRemoveRecipient(recipient),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: blackAndWhite.shade700,
            shape: const CircleBorder(),
            padding: _removeRecipientTagButtonPadding,
          ),
          child: Image.asset(
            Assets.images.close.path,
            color: blackAndWhite.shade100,
          ),
        );

        return PicnicTag(
          padding: _tagPadding,
          title: recipient.username,
          suffixIcon: removeTagButton,
          backgroundColor: blackAndWhite.shade300,
          blurRadius: null,
          titleTextStyle: theme.styles.subtitle20.copyWith(color: blackAndWhite.shade700),
          borderRadius: _tagBorderRadius,
        );
      },
    ).toList();

    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 110),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: _tagSpacing,
            runSpacing: _tagSpacing,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...picnicTags,
              lastChild,
            ],
          ),
        ),
      ),
    );
  }
}

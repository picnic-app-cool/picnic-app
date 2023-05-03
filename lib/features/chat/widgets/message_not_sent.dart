import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MessageNotSent extends StatelessWidget {
  const MessageNotSent._(this._text, {super.key});

  factory MessageNotSent.short({Key? key}) {
    return MessageNotSent._(
      appLocalizations.notSentMessageShort,
      key: key,
    );
  }

  factory MessageNotSent.long({Key? key}) {
    return MessageNotSent._(
      appLocalizations.notSentMessage,
      key: key,
    );
  }

  final String _text;
  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    final pink = PicnicTheme.of(context).colors.pink;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.info,
          color: pink,
          size: _iconSize,
        ),
        const Gap(8),
        Text(
          _text,
          style: TextStyle(color: pink),
        ),
      ],
    );
  }
}

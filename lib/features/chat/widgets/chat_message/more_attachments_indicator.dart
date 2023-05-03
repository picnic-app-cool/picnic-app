import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MoreAttachmentsIndicator extends StatelessWidget {
  const MoreAttachmentsIndicator({
    required this.attachmentsCount,
    required this.index,
    required this.child,
    super.key,
  });

  final int attachmentsCount;
  final int index;
  final Widget child;

  static const _minCount = 6;
  static const _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    final textStyle = PicnicTheme.of(context).styles.body40;

    return attachmentsCount > _minCount && index == _minCount - 1
        ? Stack(
            fit: StackFit.expand,
            children: [
              child,
              IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(_opacity),
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations.moreAttachmentsCount(attachmentsCount - _minCount),
                    style: textStyle,
                  ),
                ),
              ),
            ],
          )
        : child;
  }
}

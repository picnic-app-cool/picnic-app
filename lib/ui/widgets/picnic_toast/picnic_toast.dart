import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast_controller.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast_transition.dart';
import 'package:picnic_app/ui/widgets/shake_widget.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

const _toastDisplayDuration = Duration(seconds: 2);
const _toastOpenTransitionDuration = ShortDuration();
const _toastCloseTransitionDuration = ShortDuration();

Future<void> showPicnicToast({
  required BuildContext context,
  required WidgetBuilder builder,
  Future<void>? delay,
}) async {
  final controller = PicnicToastController(
    openTransitionDuration: _toastOpenTransitionDuration,
    closeTransitionDuration: _toastCloseTransitionDuration,
  );
  final entry = OverlayEntry(
    builder: (context) => PicnicToastTransition(
      controller: controller,
      toast: Material(
        type: MaterialType.transparency,
        child: Builder(builder: builder),
      ),
    ),
  );
  Overlay.of(context).insert(entry);
  unawaited(HapticFeedback.mediumImpact());
  await (delay ?? Future.delayed(_toastDisplayDuration));
  await controller.hide();
  entry.remove();
  entry.dispose();
}

class PicnicToast extends StatelessWidget {
  const PicnicToast({
    super.key,
    required this.text,
    this.icon,
    this.showLoading = false,
    this.shake = false,
    this.color,
  }) : _colorResolver = null;

  PicnicToast.error({
    super.key,
    required this.text,
  })  : icon = PicnicImageSource.emoji(
          Constants.emojiSeeNoEvilMonkey,
          style: const TextStyle(
            fontSize: Constants.emojiSize,
          ),
        ),
        showLoading = false,
        shake = false,
        _colorResolver = ((context) => PicnicTheme.of(context).colors.pink.shade500),
        color = null;

  final String text;
  final PicnicImageSource? icon;
  final bool showLoading;
  final bool shake;
  final Color? color;

  final Color Function(BuildContext context)? _colorResolver;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final textColor = _colorResolver?.call(context) ?? color;
    final borderRadius = BorderRadius.circular(100);
    final shadow = BoxShadow(
      color: blackAndWhite.shade900.withOpacity(0.16),
      offset: const Offset(0, 4),
      blurRadius: 40,
    );

    return ShakeWidget(
      shakeOnStart: shake,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: blackAndWhite.shade100,
              boxShadow: [shadow],
            ),
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: 20,
              right: 24,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showLoading) ...[
                  const PicnicLoadingIndicator(),
                  const Gap(10),
                ],
                if (icon != null) ...[
                  PicnicImage(
                    source: icon!,
                    alignEmoji: false,
                  ),
                  const Gap(10),
                ],
                Flexible(
                  child: Text(
                    text,
                    style: theme.styles.body20.copyWith(
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

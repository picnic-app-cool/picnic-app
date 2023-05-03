// ignore_for_file: long-method, avoid-returning-widgets
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/connection_status/domain/model/presentable_connection_status.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

Flushbar<void> connectionStatusBar({
  required BuildContext context,
  required PresentableConnectionStatus status,
}) {
  const maxWidth = 300.0;
  const shadowOpacity = 0.35;
  const blurRadius = 40.0;
  const borderRadius = 100.0;

  final picnicTheme = PicnicTheme.of(context);
  final white = picnicTheme.colors.blackAndWhite.shade100;

  return Flushbar(
    isDismissible: false,
    margin: const EdgeInsets.all(20),
    animationDuration: const LongDuration(),
    maxWidth: maxWidth,
    backgroundColor: white,
    flushbarPosition: FlushbarPosition.TOP,
    boxShadows: [
      BoxShadow(
        color: _colorForStatus(
          context: context,
          status: status,
        ).withOpacity(shadowOpacity),
        blurRadius: blurRadius,
      ),
    ],
    borderRadius: BorderRadius.circular(borderRadius),
    messageText: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _leadingIconForStatus(status: status),
          const Gap(10.0),
          Flexible(
            child: Text(
              _textForStatus(status: status),
              style: picnicTheme.styles.body20,
            ),
          ),
        ],
      ),
    ),
  );
}

Color _colorForStatus({
  required BuildContext context,
  required PresentableConnectionStatus status,
}) {
  final colors = PicnicTheme.of(context).colors;
  switch (status) {
    case PresentableConnectionStatus.online:
      return colors.green;
    case PresentableConnectionStatus.offline:
      return colors.red;
    case PresentableConnectionStatus.reconnecting:
      return colors.yellow;
    case PresentableConnectionStatus.none:
      return colors.blackAndWhite;
  }
}

String _textForStatus({
  required PresentableConnectionStatus status,
}) {
  switch (status) {
    case PresentableConnectionStatus.online:
      return appLocalizations.connectedToInternet;
    case PresentableConnectionStatus.offline:
      return appLocalizations.noInternetConnection;
    case PresentableConnectionStatus.reconnecting:
      return appLocalizations.tryingToReconnect;
    case PresentableConnectionStatus.none:
      return '';
  }
}

Widget _leadingIconForStatus({
  required PresentableConnectionStatus status,
}) {
  switch (status) {
    case PresentableConnectionStatus.online:
      return PicnicImage(
        source: PicnicImageSource.asset(
          ImageUrl(Assets.images.online.path),
        ),
      );
    case PresentableConnectionStatus.offline:
      return PicnicImage(
        source: PicnicImageSource.asset(
          ImageUrl(Assets.images.offline.path),
        ),
      );
    case PresentableConnectionStatus.reconnecting:
      return const PicnicLoadingIndicator();
    case PresentableConnectionStatus.none:
      return const SizedBox.shrink();
  }
}

// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:picnic_app/features/connection_status/domain/model/presentable_connection_status.dart';
import 'package:picnic_app/features/connection_status/widgets/connection_status_bar.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class ConnectionStatusHandlerNavigator with ConnectionStatusHandlerRoute {
  ConnectionStatusHandlerNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ConnectionStatusHandlerRoute {
  Flushbar<dynamic>? flushbar;

  Future<void> showConnectionStatus({required PresentableConnectionStatus status}) async {
    await flushbar?.dismiss();
    if (status == PresentableConnectionStatus.none) {
      return;
    }

    final context = AppNavigator.rootNavigatorContext;
    flushbar = connectionStatusBar(
      context: context,
      status: status,
    );
    await flushbar?.show(context);
  }

  AppNavigator get appNavigator;
}

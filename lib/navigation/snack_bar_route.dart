import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin SnackBarRoute {
  Future<void> showSnackBar(
    String text,
  ) async =>
      ScaffoldMessenger.of(AppNavigator.currentContext).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );

  void showSnackBarWithWidget(
    Widget widget,
  ) =>
      Flushbar(
        backgroundColor: Colors.transparent,
        messageText: widget,
        duration: const Duration(seconds: 5),
      ).show(
        AppNavigator.currentContext,
      );
}

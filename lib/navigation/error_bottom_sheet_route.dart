import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/utils/task_queue.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/buttom_sheet/error_bottom_sheet.dart';

mixin ErrorBottomSheetRoute {
  static final _key = GlobalKey<State>();
  static final _notifier = ErrorBottomSheetNotifier();
  static final _taskQueue = TaskQueue();

  // ignore: long-method
  Future<void> showError(
    DisplayableFailure failure, {
    BuildContext? context,
    ErrorDialogShowMode showMode = ErrorDialogShowMode.ignoreIfAlreadyVisible,
    VoidCallback? onTapButton,
  }) {
    final _completer = Completer();
    return _taskQueue.run(() {
      if (_key.currentState != null) {
        switch (showMode) {
          case ErrorDialogShowMode.ignoreIfAlreadyVisible:
            return Future.value();
          case ErrorDialogShowMode.overrideCurrent:
            _notifier.addFailure(failure);
            return Future.value();
          case ErrorDialogShowMode.showAfterCurrent:
            Navigator.of(context ?? AppNavigator.currentContext).pop();
            _showDialog(
              failure: failure,
              context: context,
              onTapButton: onTapButton,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) => _completer.complete(Future.value()));
            return _completer.future;
        }
      } else {
        _showDialog(
          failure: failure,
          context: context,
          onTapButton: onTapButton,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) => _completer.complete(Future.value()));
        return _completer.future;
      }
    });
  }

  void _showDialog({
    required DisplayableFailure failure,
    required BuildContext? context,
    VoidCallback? onTapButton,
  }) {
    _notifier.addFailure(failure);
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      context: context ?? AppNavigator.currentContext,
      builder: (BuildContext context) {
        return ErrorBottomSheet(
          key: _key,
          notifier: _notifier,
          onTapButton: onTapButton,
        );
      },
    );
  }
}

enum ErrorDialogShowMode {
  ignoreIfAlreadyVisible,
  overrideCurrent,
  showAfterCurrent,
}

class ErrorBottomSheetNotifier extends ChangeNotifier {
  late DisplayableFailure failure;

  void addFailure(DisplayableFailure failure) {
    this.failure = failure;
    notifyListeners();
  }
}

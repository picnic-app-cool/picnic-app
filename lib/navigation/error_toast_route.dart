import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast.dart';

mixin ErrorToastRoute {
  BuildContext get context;

  Future<void> showToastError(DisplayableFailure failure, {BuildContext? context}) {
    return showPicnicToast(
      context: context ?? this.context,
      builder: (context) => PicnicToast.error(text: failure.message),
    );
  }
}

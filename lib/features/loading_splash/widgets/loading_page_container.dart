import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';

/// Used across loading splash pages to show proper background and dialog
class LoadingPageContainer extends StatelessWidget {
  const LoadingPageContainer({
    Key? key,
    required this.dialog,
  }) : super(key: key);

  final PicnicDialog dialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0.0, 0.15),
          child: dialog,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';

/// Used across all onboarding pages to show proper background and dialog
class OnboardingPageContainer extends StatelessWidget {
  const OnboardingPageContainer({
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

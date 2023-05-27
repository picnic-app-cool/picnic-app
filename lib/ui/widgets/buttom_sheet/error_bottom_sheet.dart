import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ErrorBottomSheet extends StatefulWidget {
  const ErrorBottomSheet({
    required this.notifier,
    this.onTapButton,
    super.key,
  });

  final ErrorBottomSheetNotifier notifier;
  final VoidCallback? onTapButton;

  @override
  State<ErrorBottomSheet> createState() => _ErrorBottomSheetState();
}

class _ErrorBottomSheetState extends State<ErrorBottomSheet> {
  static const _modalHeight = 316.0;
  static const _circleSize = 88.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return SizedBox(
      height: _modalHeight,
      child: AnimatedBuilder(
        animation: widget.notifier,
        builder: (BuildContext context, Widget? child) {
          final failure = widget.notifier.failure;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0XFFf2f2f2),
                    shape: BoxShape.circle,
                  ),
                  height: _circleSize,
                  width: _circleSize,
                  child: Center(
                    child: Image.asset(
                      Assets.images.monkey.path,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  failure.title,
                  style: theme.styles.subtitle40,
                  textAlign: TextAlign.start,
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  failure.message,
                  style: theme.styles.caption20,
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PicnicButton(
                  title: appLocalizations.errorDialogOk,
                  size: PicnicButtonSize.large,
                  color: theme.colors.pink.shade500,
                  onTap: () => _onTapButton(context),
                  borderRadius: const PicnicButtonRadius(radius: 40),
                ),
              ),
              const Gap(40),
            ],
          );
        },
      ),
    );
  }

  void _onTapButton(BuildContext context) {
    Navigator.of(context).pop();
    widget.onTapButton?.call();
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class PicnicLinkEmptyView extends StatelessWidget {
  const PicnicLinkEmptyView({
    Key? key,
    required this.onTapPaste,
  }) : super(key: key);

  final VoidCallback onTapPaste;
  static const viewPortFraction = 0.7;
  static const imageScale = 3.0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 5.55;
    return Column(
      /// Made it center because the link module below is removed temporarily.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SizedBox(
            height: height,
            child: InkWell(
              onTap: onTapPaste,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                dashPattern: const [5, 5],
                color: Colors.grey,
                child: Center(
                  child: Text(appLocalizations.tapToPasteDescriptiveAction),
                ),
              ),
            ),
          ),
        ),

        /// Check Git history of this file whenever the link post widgets are to be brought back to life
      ],
    );
  }
}

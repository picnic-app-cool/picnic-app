import 'package:flutter/material.dart';

class KeyboardSimulatorView extends StatelessWidget {
  const KeyboardSimulatorView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = mediaQueryData.size;
    final keyWidth = size.width / 10;
    final keyboardHeight = size.height / 2.5;
    final newBottomInset = mediaQueryData.viewInsets.bottom + keyboardHeight;
    return Stack(
      children: [
        MediaQuery(
          data: mediaQueryData.copyWith(
            viewInsets: mediaQueryData.viewInsets.copyWith(
              bottom: newBottomInset,
            ),
          ),
          child: child,
        ),
        Positioned(
          bottom: mediaQueryData.viewInsets.bottom,
          left: 0,
          right: 0,
          child: SizedBox(
            height: keyboardHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey.shade400),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  spacing: keyWidth / 5,
                  runSpacing: keyWidth / 5,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    40,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade600,
                        ),
                        width: keyWidth,
                        height: keyWidth * 1.3,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

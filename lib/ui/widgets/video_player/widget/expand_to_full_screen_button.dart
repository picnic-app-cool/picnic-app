import 'package:flutter/material.dart';

class ExpandToFullScreenButton extends StatelessWidget {
  const ExpandToFullScreenButton({
    required this.isFullScreen,
    required this.expandIconIsHidden,
    required this.onTapExpand,
  });

  final bool isFullScreen;
  final bool expandIconIsHidden;
  final VoidCallback onTapExpand;

  static const barHeight = 120;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapExpand,
      child: AnimatedOpacity(
        opacity: expandIconIsHidden ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
          color: Colors.white,
        ),
      ),
    );
  }
}

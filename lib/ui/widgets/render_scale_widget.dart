import 'package:flutter/material.dart';

class RenderScaleWidget extends StatelessWidget {
  const RenderScaleWidget({
    Key? key,
    this.renderSize,
    this.widgetSize,
    required this.child,
  }) : super(key: key);

  final Size? renderSize;
  final Size? widgetSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final renderWidth = renderSize?.width ?? screenSize.width;
    final renderHeight = renderSize?.height ?? screenSize.height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        final widgetWidth = widgetSize?.width ?? size.maxWidth;
        final widgetHeight = widgetSize?.height ?? size.maxHeight;
        final scaleX = widgetWidth / renderWidth;
        final scaleY = widgetHeight / renderHeight;
        final translateX = renderWidth * (1 - scaleX) / 2;
        final translateY = renderHeight * (1 - scaleY) / 2;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Transform.translate(
              offset: Offset(-translateX, -translateY),
              child: Transform.scale(
                scaleX: scaleX,
                scaleY: scaleY,
                child: SizedBox(
                  width: renderWidth,
                  height: renderHeight,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

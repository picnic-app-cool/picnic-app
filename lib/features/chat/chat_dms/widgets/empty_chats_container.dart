import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/no_chats_card.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class EmptyChatsContainer extends StatelessWidget {
  const EmptyChatsContainer({super.key});

  static const _arrowRotationAngle = 11 / 360;
  static const _padding = EdgeInsets.only(bottom: 50);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxHeight = constraint.maxHeight;

        final contentMinHeight = 2 / 3 * maxHeight;
        final arrowMaxHeight = maxHeight / 3;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: contentMinHeight),
              child: Column(
                children: [
                  const NoChatsCard(),
                  Container(
                    constraints: BoxConstraints(maxHeight: arrowMaxHeight),
                    padding: _padding,
                    child: Transform.rotate(
                      angle: _arrowRotationAngle,
                      child: Image.asset(
                        Assets.images.pointingArrow.path,
                        fit: BoxFit.fill,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

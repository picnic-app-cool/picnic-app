import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/attachments_grid.dart';

import '../../../../test_utils/golden_tests_utils.dart';

void main() {
  final attachmentsCount = [1, 2, 3, 4, 5, 6, 7];

  final colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple, Colors.white];

  widgetScreenshotTest(
    "attachment_grid",
    widgetBuilder: (context) => GoldenTestGroup(
      children: attachmentsCount.map(
        (count) {
          final name = '$count Attachment(s)';
          final attachments = List.filled(count, const Attachment.empty());
          return GoldenTestScenario(
            name: name,
            child: TestWidgetContainer(
              child: AttachmentsGrid(
                attachments: attachments,
                itemBuilder: (_, index) => ColoredBox(color: colors[index]),
              ),
            ),
          );
        },
      ).toList(),
    ),
  );
}

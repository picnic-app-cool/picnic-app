import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/more_attachments_indicator.dart';

import '../../../../test_extensions/widget_tester_extensions.dart';

void main() {
  group('MoreAttachmentsIndicator', () {
    MoreAttachmentsIndicator getMoreAttachmentsIndicator({required int attachmentsCount}) {
      return MoreAttachmentsIndicator(
        attachmentsCount: attachmentsCount,
        index: 5,
        child: const Placeholder(),
      );
    }

    final valuesToExpected = {
      7: '+1',
      8: '+2',
      11: '+5',
    };

    valuesToExpected.forEach((value, expected) {
      testWidgets('shows $expected when there are $value attachments', (tester) async {
        final moreAttachmentsIndicator = getMoreAttachmentsIndicator(attachmentsCount: value);
        await tester.setupWidget(moreAttachmentsIndicator);

        final text = find.text(expected);
        expect(text, findsOneWidget);
      });
    });

    for (final value in [1, 2, 3, 4, 5, 6]) {
      testWidgets('shows NOTHING when there are $value attachments', (tester) async {
        final moreAttachmentsIndicator = getMoreAttachmentsIndicator(attachmentsCount: value);
        await tester.setupWidget(moreAttachmentsIndicator);

        final stack = find.byType(Stack);

        expect(stack, findsNothing);
      });
    }
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/buttom_sheet/error_bottom_sheet.dart';

import '../../test_utils/test_app_widget.dart';

void main() {
  testWidgets('should open one error even if called twice', (widgetTester) async {
    final navigator = _TestNavigator();
    await widgetTester.pumpWidget(
      TestAppWidget(
        child: _SamplePageWithErrors(
          onButtonPress: (context) async {
            await navigator.showError(
              DisplayableFailure.commonError(),
              context: context,
            );
            await navigator.showError(
              DisplayableFailure.commonError(),
              context: context,
            );
          },
        ),
      ),
    );

    await _triggerButtonPress(widgetTester);
    final bottomSheet = find.byType(ErrorBottomSheet);
    expect(bottomSheet, findsOneWidget);
  });
}

Future<void> _triggerButtonPress(WidgetTester widgetTester) async {
  final button = find.byKey(const ValueKey(0));
  await widgetTester.tap(button);
  await widgetTester.pumpAndSettle();
}

class _SamplePageWithErrors extends StatelessWidget {
  const _SamplePageWithErrors({
    required this.onButtonPress,
  });

  final Function(BuildContext context) onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: const ValueKey(0),
          onPressed: () => onButtonPress.call(context),
          child: const Text("press me"),
        ),
      ),
    );
  }
}

class _TestNavigator with ErrorBottomSheetRoute {}

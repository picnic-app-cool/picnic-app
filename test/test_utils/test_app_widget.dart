import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import 'golden_tests_utils.dart';

class TestAppWidget extends StatelessWidget {
  const TestAppWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(
        size: testDevices.first.size,
        padding: testDevices.first.safeArea,
      ),
      child: PicnicTheme(
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
          ],
          home: child,
        ),
      ),
    );
  }
}

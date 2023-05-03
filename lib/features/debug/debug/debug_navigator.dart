import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_navigator.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_navigator.dart';
import 'package:picnic_app/features/debug/log_console/log_console_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';

class DebugNavigator
    with
        NoRoutes,
        LogConsoleRoute,
        FeaturesIndexRoute,
        SnackBarRoute,
        ErrorBottomSheetRoute,
        EditHeaderRoute,
        FeatureFlagsRoute {
  DebugNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin EditHeaderRoute {
  Future<MapEntry<String, String>?> showEditHeaderDialog({MapEntry<String, String>? header}) => showDialog(
        context: AppNavigator.currentContext,
        builder: (context) => _EditHeaderDialog(header: header),
      );
}

class _EditHeaderDialog extends StatefulWidget {
  const _EditHeaderDialog({
    Key? key,
    required this.header,
  }) : super(key: key);

  final MapEntry<String, String>? header;

  @override
  State<_EditHeaderDialog> createState() => _EditHeaderDialogState();
}

class _EditHeaderDialogState extends State<_EditHeaderDialog> {
  late String key;
  late String value;

  @override
  void initState() {
    super.initState();
    key = widget.header?.key ?? '';
    value = widget.header?.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit GraphQL header"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'key'),
            onChanged: (text) => setState(() => key = text),
          ),
          const Gap(8),
          TextField(
            decoration: const InputDecoration(hintText: 'value'),
            onChanged: (text) => setState(() => value = text),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(MapEntry(key, value)),
          child: const Text("save"),
        ),
      ],
    );
  }
}

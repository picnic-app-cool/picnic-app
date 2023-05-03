import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({
    Key? key,
    required this.info,
    required this.onLongPressAppInfo,
  }) : super(key: key);

  final AppInfo info;
  final VoidCallback onLongPressAppInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPressAppInfo,
      child: Center(child: Text('${info.appVersion} (${info.buildNumber}) - ${info.buildSource}')),
    );
  }
}

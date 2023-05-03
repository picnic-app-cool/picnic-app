import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class AppInfoBottomSheet extends StatelessWidget {
  const AppInfoBottomSheet({
    Key? key,
    required this.appInfo,
    required this.onTapClose,
  }) : super(key: key);

  final AppInfo appInfo;
  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    final styles = PicnicTheme.of(context).styles;
    final body10 = styles.body10;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.images.checkboxSquare.path),
              Expanded(
                child: Text(
                  appLocalizations.buildInfoDescription,
                  style: styles.title30,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const Gap(20),
          Text(
            appLocalizations.appInfoLabel(
              appInfo.appVersion,
              appInfo.buildNumber,
              appInfo.buildSource,
            ),
            style: body10,
          ),
          const Gap(16),
          Text(
            appLocalizations.systemInfoLabel(appInfo.deviceInfo.platform.value, appInfo.deviceInfo.osVersion),
            style: body10,
          ),
          const Gap(16),
          Text(
            appLocalizations.deviceInfoLabel(appInfo.deviceInfo.device),
            style: body10,
          ),
          const Gap(20),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
        ],
      ),
    );
  }
}

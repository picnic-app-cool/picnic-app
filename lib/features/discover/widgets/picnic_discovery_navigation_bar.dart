import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class PicnicDiscoveryNavigationBar extends StatelessWidget {
  const PicnicDiscoveryNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicnicAppBar(
      iconPathLeft: Assets.images.close.path,
      titleText: appLocalizations.discoveryDiscover,
    );
  }
}

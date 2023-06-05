import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';

class PicnicDiscoverySearchBar extends StatelessWidget {
  const PicnicDiscoverySearchBar({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  static const radius = 100.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: PicnicSoftSearchBar(
        controller: controller,
        focusNode: focusNode,
        hintText: appLocalizations.discoverySearch,
      ),
    );
  }
}

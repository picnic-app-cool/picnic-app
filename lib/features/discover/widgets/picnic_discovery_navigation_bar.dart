import 'package:flutter/material.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class PicnicDiscoveryNavigationBar extends StatelessWidget {
  const PicnicDiscoveryNavigationBar({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return PicnicAppBar(
      child: PicnicDiscoverySearchBar(
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }
}

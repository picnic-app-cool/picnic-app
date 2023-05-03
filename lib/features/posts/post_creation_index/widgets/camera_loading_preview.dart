import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CameraLoadingPreview extends StatelessWidget {
  const CameraLoadingPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
    return Scaffold(
      body: Center(
        child: PicnicLoadingIndicator(
          color: blackAndWhite.shade100,
        ),
      ),
      backgroundColor: blackAndWhite.shade900,
    );
  }
}

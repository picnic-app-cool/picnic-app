import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

mixin WebViewRoute {
  Future<void> openWebView(String url) async {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
    final whiteColor = blackAndWhite.shade100;
    final blackColor = blackAndWhite.shade900;
    return launch(
      url,
      customTabsOption: CustomTabsOption(
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: CustomTabsSystemAnimation.slideIn(),
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: whiteColor,
        preferredControlTintColor: blackColor,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context => AppNavigator.currentContext;
}

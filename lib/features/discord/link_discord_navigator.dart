import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/revoke_webhook_bottom_sheet_route.dart';

class LinkDiscordNavigator with ErrorBottomSheetRoute, RevokeWebhookBottomSheetRoute, CloseRoute {
  LinkDiscordNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin LinkDiscordRoute {
  Future<void> openLinkDiscord(LinkDiscordInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(LinkDiscordPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

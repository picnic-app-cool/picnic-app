import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds/widgets/send_seeds_confirmation_column.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SellSeedsNavigator
    with
        SellSeedsSecondStepRoute,
        CloseRoute,
        ErrorBottomSheetRoute,
        SeedRecipientsRoute,
        SellSeedsRoute,
        ConfirmSendSeedsRoute {
  SellSeedsNavigator(
    this.appNavigator,
    this.navigatorKey,
  );

  @override
  final AppNavigator appNavigator;
  final SellSeedsNavigatorKey navigatorKey;

  @override
  BuildContext? get context => navigatorKey.currentContext;
}

mixin SellSeedsRoute {
  Future<void> openSellSeeds(SellSeedsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SellSeedsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin ConfirmSendSeedsRoute {
  Future<bool?> showConfirmSendSeedsRoute({
    required PublicProfile recipient,
    required String circleName,
    required int seedAmount,
  }) =>
      showPicnicBottomSheet<bool?>(
        useRootNavigator: true,
        SendSeedsConfirmationColumn(
          recipient: recipient,
          onTapClose: () => appNavigator.closeWithResult(false),
          onTapSendSeeds: () => appNavigator.closeWithResult(true),
          circleName: circleName,
          seedAmount: seedAmount,
        ),
      );

  AppNavigator get appNavigator;
}

typedef SellSeedsNavigatorKey = GlobalKey<NavigatorState>;

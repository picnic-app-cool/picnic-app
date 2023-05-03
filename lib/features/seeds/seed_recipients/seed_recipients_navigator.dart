import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SeedRecipientsNavigator with ErrorBottomSheetRoute, CloseWithResultRoute<PublicProfile> {
  SeedRecipientsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SeedRecipientsRoute {
  Future<PublicProfile?> openRecipients(SeedRecipientsInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<SeedRecipientsPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}

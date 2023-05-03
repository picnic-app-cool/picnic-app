import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CreateNewCollectionNavigator with CloseRoute, CloseWithResultRoute<Collection?>, ErrorBottomSheetRoute {
  CreateNewCollectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CreateNewCollectionRoute {
  Future<Collection?> openCreateNewCollectionBottomSheet(
    CreateNewCollectionInitialParams initialParams,
  ) =>
      showPicnicBottomSheet<Collection?>(
        getIt<CreateNewCollectionPage>(param1: initialParams),
        useRootNavigator: true,
      );

  AppNavigator get appNavigator;
}

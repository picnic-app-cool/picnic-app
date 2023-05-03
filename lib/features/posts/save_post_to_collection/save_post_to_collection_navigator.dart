import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_page.dart';
import 'package:picnic_app/features/profile/collection/collection_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SavePostToCollectionNavigator with CloseRoute, ErrorBottomSheetRoute, CreateNewCollectionRoute, CollectionRoute {
  SavePostToCollectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SavePostToCollectionRoute {
  Future<bool?> openSavePostToCollectionBottomSheet(
    SavePostToCollectionInitialParams initialParams,
  ) =>
      showPicnicBottomSheet<bool?>(
        getIt<SavePostToCollectionPage>(param1: initialParams),
        useRootNavigator: true,
      );

  AppNavigator get appNavigator;
}

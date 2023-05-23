import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_page.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/vertical_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class CollectionNavigator with ErrorBottomSheetRoute, VerticalActionBottomSheetRoute, CloseRoute, SingleFeedRoute {
  CollectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  void showDeleteCollectionConfirmation({required VoidCallback onDelete}) => showVerticalActionBottomSheet(
        title: appLocalizations.deleteCollectionDialogTitle,
        description: appLocalizations.deleteCollectionDialogDescription,
        actions: [
          ActionBottom(
            icon: Assets.images.delete.path,
            label: appLocalizations.deleteCollectionConfirmationAction,
            isPrimary: true,
            action: onDelete,
          ),
        ],
        onTapClose: appNavigator.close,
      );

  void showDeletePostConfirmation({
    required String title,
    required VoidCallback onDelete,
    required VoidCallback onClose,
  }) =>
      showVerticalActionBottomSheet(
        title: title,
        description: appLocalizations.deletePostsConfirmationMessage,
        actions: [
          ActionBottom(
            label: appLocalizations.deleteMessageConfirmAction,
            isPrimary: true,
            action: onDelete,
          ),
        ],
        onTapClose: onClose,
      );

  void showCollectionSettings({required VoidCallback onDelete}) => showVerticalActionBottomSheet(
        actions: [
          ActionBottom(
            icon: Assets.images.delete.path,
            label: appLocalizations.deleteCollectionActionTitle,
            action: onDelete,
          ),
        ],
        onTapClose: appNavigator.close,
      );
}

mixin CollectionRoute {
  Future<void> openCollection(CollectionInitialParams initialParams, {bool useRoot = false}) async {
    return appNavigator.push(
      materialRoute(getIt<CollectionPage>(param1: initialParams)),
      useRoot: useRoot,
    );
  }

  AppNavigator get appNavigator;
}

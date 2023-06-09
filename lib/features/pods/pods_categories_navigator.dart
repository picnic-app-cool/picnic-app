import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_page.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/sort_bottom_sheet.dart';

class PodsCategoriesNavigator
    with AddCirclePodRoute, ErrorBottomSheetRoute, ShareRoute, SortPodsBottomSheetRoute, CloseRoute, PreviewPodRoute {
  PodsCategoriesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PodsCategoriesRoute {
  Future<void> openPodsCategories(PodsCategoriesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(PodsCategoriesPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin SortPodsBottomSheetRoute {
  Future<void> openSortPodsBottomSheet({
    required void Function(AppOrder) onTapSort,
    required List<AppOrder> sortOptions,
    required AppOrder selectedSortOption,
  }) async {
    return showPicnicBottomSheet(
      SortBottomSheet<AppOrder>(
        onTapSort: onTapSort,
        onTapClose: appNavigator.close,
        sortOptions: sortOptions,
        selectedSortOption: selectedSortOption,
        valueToDisplay: (value) => value.valueToDisplay,
      ),
    );
  }

  AppNavigator get appNavigator;
}

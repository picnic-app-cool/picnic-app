import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_page.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/sort_bottom_sheet.dart';

class ReportsListNavigator
    with
        ResolvedReportDetailsRoute,
        ReportedMessageRoute,
        ErrorBottomSheetRoute,
        PostDetailsRoute,
        CommentChatRoute,
        ProfileRoute,
        SortReportsBottomSheetRoute,
        CloseRoute {
  ReportsListNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin ReportsListRoute {
  Future<void> openReportsList(ReportsListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ReportsListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin SortReportsBottomSheetRoute {
  Future<void> openSortReportsBottomSheet({
    required void Function(CircleReportsFilterBy) onTapSort,
    required List<CircleReportsFilterBy> sortOptions,
    required CircleReportsFilterBy selectedSortOption,
  }) async {
    return showPicnicBottomSheet(
      SortBottomSheet<CircleReportsFilterBy>(
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

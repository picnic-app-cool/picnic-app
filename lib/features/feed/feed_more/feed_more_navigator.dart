import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class FeedMoreNavigator with CloseWithResultRoute<Feed> {
  FeedMoreNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin FeedMoreRoute {
  Future<Feed?> openFeedMore(FeedMoreInitialParams initialParams) => showPicnicBottomSheet<Feed>(
        getIt<FeedMorePage>(
          param1: initialParams,
        ),
        useRootNavigator: true,
      );

  AppNavigator get appNavigator;
}

import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class PollPostNavigator with CloseWithResultRoute<PostRouteResult>, FxEffectRoute, ErrorBottomSheetRoute {
  PollPostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PollPostRoute {
  Future<PostRouteResult?> openPollPost(PollPostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PollPostPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

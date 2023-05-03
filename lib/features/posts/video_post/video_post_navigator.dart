import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class VideoPostNavigator with CloseWithResultRoute<PostRouteResult>, ErrorBottomSheetRoute {
  VideoPostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

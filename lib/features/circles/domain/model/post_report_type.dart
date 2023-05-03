import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';

enum PostReportType {
  userBanned,
  postRemoved,
  resolvedWithNoAction;

  PostRouteResult toPostRouteResult() {
    switch (this) {
      case PostReportType.userBanned:
        return const PostRouteResult(userBanned: true);
      case PostReportType.postRemoved:
        return const PostRouteResult(postRemoved: true);
      case PostReportType.resolvedWithNoAction:
        return const PostRouteResult.empty();
    }
  }
}

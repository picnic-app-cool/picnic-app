import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_actions_bottom_sheet.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin CommentActionsRoute {
  //ignore: long-parameter-list
  void showCommentActionBottomSheet({
    required BasicComment comment,
    required VoidCallback onTapReply,
    required VoidCallback onTapReport,
    required VoidCallback onTapLike,
    required VoidCallback onTapClose,
    required VoidCallback? onTapDelete,
    required VoidCallback? onTapPin,
    required VoidCallback? onTapUnpin,
    required VoidCallback? onTapShare,
  }) {
    showPicnicBottomSheet(
      CommentActionsBottomSheet(
        comment: comment,
        onTapReply: onTapReply,
        onTapReport: onTapReport,
        onTapLike: onTapLike,
        onTapClose: onTapClose,
        onTapDelete: onTapDelete,
        onTapPin: onTapPin,
        onTapUnpin: onTapUnpin,
        onTapShare: onTapShare,
      ),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;
}

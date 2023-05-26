import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/widgets/changing_pinned_comment_bottom_sheet.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin ChangingPinnedCommentRoute {
  //ignore: long-parameter-list
  void showChangingPinnedComment({
    required BasicComment comment,
    required VoidCallback onTapChange,
    required VoidCallback onTapCancel,
    required VoidCallback onTapShare,
    required Function(String) onTapShareCommentItem,
  }) {
    showPicnicBottomSheet(
      ChangingPinnedCommentBottomSheet(
        comment: comment,
        onTapChange: onTapChange,
        onTapCancel: onTapCancel,
        onTapShare: onTapShare,
        onTapShareCommentItem: onTapShareCommentItem,
      ),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;
}

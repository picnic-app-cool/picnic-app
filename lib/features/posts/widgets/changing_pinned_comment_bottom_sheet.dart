import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ChangingPinnedCommentBottomSheet extends StatelessWidget {
  const ChangingPinnedCommentBottomSheet({
    Key? key,
    required this.comment,
    required this.onTapChange,
    required this.onTapCancel,
    required this.onTapShare,
    required this.onTapShareCommentItem,
  }) : super(key: key);

  final BasicComment comment;
  final VoidCallback onTapChange;
  final VoidCallback onTapCancel;
  final VoidCallback onTapShare;
  final Function(String) onTapShareCommentItem;

  static const topAvatarSize = 40.0;
  static const _horizontalPadding = 20.0;
  static const _verticalSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    return Container(
      padding: EdgeInsets.only(
        left: _horizontalPadding,
        right: _horizontalPadding,
        bottom: bottomNavBarHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(_verticalSpacing),
          Text(
            appLocalizations.changePinnedCommentConfirmationTitle,
            style: theme.styles.title30,
          ),
          const Gap(_verticalSpacing),
          Text(
            appLocalizations.changePinnedCommentConfirmationMessage,
            style: theme.styles.body0.copyWith(color: blackAndWhite.shade600),
          ),
          const Gap(_verticalSpacing),
          Text(
            appLocalizations.changePinnedCommentConfirmationCurrentPinnedComment,
            style: theme.styles.body10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CommentTreeItem(
              treeComment: comment as TreeComment,
              showChildren: false,
              maxTextLines: Constants.commentInBottomSheetMaxLines,
              onTapShareCommentItem: onTapShareCommentItem,
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: PicnicButton(
                  title: appLocalizations.changePinnedCommentConfirmationButtonTitle,
                  onTap: onTapChange,
                ),
              ),
            ],
          ),
          const Gap(2),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.cancelAction,
              onTap: onTapCancel,
            ),
          ),
          const Gap(_verticalSpacing),
        ],
      ),
    );
  }
}

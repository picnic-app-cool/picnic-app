import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_preview_item.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item/comment_tree_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class CommentActionsBottomSheet extends StatelessWidget {
  const CommentActionsBottomSheet({
    Key? key,
    required this.comment,
    required this.onTapReply,
    required this.onTapClose,
    required this.onTapLike,
    required this.onTapReport,
    required this.onTapDelete,
    required this.onTapPin,
    required this.onTapUnpin,
    required this.onTapShare,
    required this.onTapShareCommentItem,
  }) : super(key: key);

  final BasicComment comment;
  final VoidCallback onTapReply;
  final VoidCallback onTapLike;
  final VoidCallback onTapReport;
  final VoidCallback onTapClose;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapPin;
  final VoidCallback? onTapUnpin;
  final VoidCallback? onTapShare;
  final Function(String) onTapShareCommentItem;

  static const topAvatarSize = 40.0;
  static const _horizontalPadding = 20.0;
  static const _verticalSpacing = 20.0;
  static const _iconWidth = 20.0;
  static const _opacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    final divider = Divider(
      color: blackAndWhite.withOpacity(_opacity),
    );

    final iconColor = theme.colors.darkBlue;

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
            appLocalizations.commentActionsTitle,
            style: theme.styles.subtitle40,
          ),
          if (comment is CommentPreview)
            CommentPreviewItem(comment: comment as CommentPreview)
          else if (comment is TreeComment)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: CommentTreeItem(
                treeComment: comment as TreeComment,
                showChildren: false,
                maxTextLines: Constants.commentInBottomSheetMaxLines,
                onTapShareCommentItem: onTapShareCommentItem,
              ),
            ),
          divider,
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: PicnicActionButton(
                  icon: Image.asset(
                    Assets.images.infoOutlined.path,
                    color: iconColor,
                    fit: BoxFit.contain,
                    width: _iconWidth,
                  ),
                  label: appLocalizations.reportAction,
                  onTap: onTapReport,
                ),
              ),
              Expanded(
                child: PicnicActionButton(
                  icon: Image.asset(
                    Assets.images.reply.path,
                    color: iconColor,
                    fit: BoxFit.contain,
                    width: _iconWidth,
                  ),
                  label: appLocalizations.replyAction,
                  onTap: onTapReply,
                ),
              ),
              if (onTapDelete != null)
                Expanded(
                  child: PicnicActionButton(
                    icon: Image.asset(
                      Assets.images.delete.path,
                      color: iconColor,
                      fit: BoxFit.contain,
                      width: _iconWidth,
                    ),
                    label: appLocalizations.delete,
                    onTap: onTapDelete,
                  ),
                ),
              if (onTapPin != null)
                Expanded(
                  child: PicnicActionButton(
                    icon: Image.asset(
                      Assets.images.commentActionPin.path,
                      color: iconColor,
                      fit: BoxFit.contain,
                      width: _iconWidth,
                    ),
                    label: appLocalizations.commentActionPin,
                    onTap: onTapPin,
                  ),
                ),
              if (onTapUnpin != null)
                Expanded(
                  child: PicnicActionButton(
                    icon: Image.asset(
                      Assets.images.commentActionUnpin.path,
                      color: iconColor,
                      fit: BoxFit.contain,
                      width: _iconWidth,
                    ),
                    label: appLocalizations.commentActionUnpin,
                    onTap: onTapUnpin,
                  ),
                ),
              Expanded(
                child: PicnicActionButton(
                  icon: Image.asset(
                    comment.myReaction == LikeDislikeReaction.like
                        ? Assets.images.heartBold.path
                        : Assets.images.heart.path,
                    color: iconColor,
                    fit: BoxFit.contain,
                    width: _iconWidth,
                  ),
                  label: comment.myReaction == LikeDislikeReaction.like
                      ? appLocalizations.unlikeLabel
                      : appLocalizations.likeLabel,
                  onTap: onTapLike,
                ),
              ),
              if (onTapShare != null)
                Expanded(
                  child: PicnicActionButton(
                    icon: Image.asset(
                      Assets.images.share.path,
                      color: iconColor,
                      fit: BoxFit.contain,
                      width: _iconWidth,
                    ),
                    label: appLocalizations.shareAction,
                    onTap: () => onTapShare,
                  ),
                ),
            ],
          ),
          const Gap(_verticalSpacing),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
          const Gap(_verticalSpacing),
        ],
      ),
    );
  }
}

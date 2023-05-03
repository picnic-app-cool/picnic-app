import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_visibility_tracker.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/icon_button_with_counter.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/like_button_with_counter.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_dimensions.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_heartbeat_animation.dart';

class HorizontalVideoOverlay extends StatefulWidget with HasPresenter<PostOverlayPresenter> {
  const HorizontalVideoOverlay({
    required this.presenter,
    super.key,
  });

  @override
  final PostOverlayPresenter presenter;

  @override
  State<HorizontalVideoOverlay> createState() => _HorizontalVideoOverlayState();
}

class _HorizontalVideoOverlayState extends State<HorizontalVideoOverlay>
    with PresenterStateMixin<PostOverlayViewModel, PostOverlayPresenter, HorizontalVideoOverlay> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100;
    const spacing = Gap(8);
    final overlayTheme = state.post.overlayTheme;

    /// this padding makes sure that we move comment's bar up when keyboard is shown
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: stateObserver(
        builder: (context, state) {
          return PostVisibilityTracker(
            postId: state.post.id,
            child: Stack(
              alignment: Alignment.center,
              children: [
                stateObserver(
                  buildWhen: (prev, current) => prev.heartLastAnimatedAt != current.heartLastAnimatedAt,
                  builder: (context, state) {
                    return PicnicHeartbeatAnimation(
                      heartLastAnimatedAt: state.heartLastAnimatedAt,
                    );
                  },
                ),
                Column(
                  children: [
                    stateObserver(
                      builder: (context, state) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: state.onTapBack,
                              child: Image.asset(
                                Assets.images.backArrow.path,
                                color: whiteColor,
                              ),
                            ),
                            Expanded(
                              child: PostSummaryBar(
                                author: state.author,
                                post: state.post,
                                onToggleFollow: presenter.onTapFollow,
                                onTapTag: presenter.onTapShowCircle,
                                onTapAuthor: presenter.onTapProfile,
                                onTapJoinCircle: presenter.onJoinCircle,
                                showTagBackground: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          stateObserver(
                            builder: (context, state) {
                              return stateListener(
                                child: SizedBox(
                                  width: VideoPlayerControlsDimensions.horizontalVideoPostButtonsWidth,
                                  child: Column(
                                    children: [
                                      LikeButtonWithCounter(
                                        isLiked: state.post.iReacted,
                                        likes: state.post.likesCount.toString(),
                                        overlayTheme: overlayTheme,
                                        onTap: presenter.onTapHeart,
                                      ),
                                      spacing,
                                      IconButtonWithCounter(
                                        onTap: presenter.onTapChat,
                                        counterText: state.post.commentsCount.toString(),
                                        overlayTheme: overlayTheme,
                                        iconPath: Assets.images.chat.path,
                                      ),
                                      spacing,
                                      IconButtonWithCounter(
                                        onTap: presenter.onTapShare,
                                        overlayTheme: overlayTheme,
                                        counterText: state.post.sharesCount.toString(),
                                        iconPath: Assets.images.upload.path,
                                      ),
                                      spacing,
                                      if (state.savedPostsEnabled)
                                        IconButtonWithCounter(
                                          onTap: presenter.onTapBookmark,
                                          isSelected: state.post.iSaved,
                                          counterText: state.post.savesCount.toString(),
                                          overlayTheme: overlayTheme,
                                          iconPath: Assets.images.bookmark.path,
                                          isLoading: state.isPostSaving,
                                        ),
                                      spacing,
                                    ],
                                  ),
                                ),
                                listenWhen: (old, newModel) =>
                                    old.replyingComment != newModel.replyingComment &&
                                    newModel.replyingComment != const CommentPreview.empty(),
                                listener: (BuildContext context, PostOverlayViewModel state) =>
                                    _focusNode.requestFocus(),
                              );
                            },
                          ),
                          if (state.showReportAction) ...[
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: PicnicButton(
                                  title: appLocalizations.reportActionsLabel,
                                  onTap: presenter.onTapReportActions,
                                  titleColor: colors.red,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    disposePresenter = false;
    super.dispose();
  }
}

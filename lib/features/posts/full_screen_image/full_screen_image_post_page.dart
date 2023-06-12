import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_caption.dart';
import 'package:picnic_app/features/posts/widgets/horizontal_post_bar_buttons.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FullScreenImagePostPage extends StatefulWidget with HasPresenter<FullScreenImagePostPresenter> {
  const FullScreenImagePostPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final FullScreenImagePostPresenter presenter;

  @override
  State<FullScreenImagePostPage> createState() => _FullScreenImagePostPageState();
}

class _FullScreenImagePostPageState extends State<FullScreenImagePostPage>
    with PresenterStateMixin<FullScreenImagePostViewModel, FullScreenImagePostPresenter, FullScreenImagePostPage> {
  static const _avatarSize = 24.0;
  static const _emojiSize = 12.0;
  static const _contentPadding = EdgeInsets.only(top: 16, left: 16);

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;

    const overlayTheme = PostOverlayTheme.light;

    return LightStatusBar(
      child: stateObserver(
        builder: (context, state) {
          final contentStats = state.post.contentStats;
          return Scaffold(
            appBar: PicnicAppBar(
              backgroundColor: blackAndWhite.shade900,
              backButtonIconColor: blackAndWhite.shade100,
              onTapBack: presenter.onTapBack,
              actions: [
                PicnicContainerIconButton(
                  iconPath: Assets.images.options.path,
                  iconTintColor: blackAndWhite.shade100,
                  onTap: presenter.onTapOptions,
                ),
              ],
              child: InkWell(
                onTap: presenter.onTapShowCircle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PicnicCircleAvatar(
                      emoji: state.circle.emoji,
                      image: state.circle.imageFile,
                      emojiSize: _emojiSize,
                      avatarSize: _avatarSize,
                      isVerified: state.circle.isVerified,
                      bgColor: blackAndWhite.shade200,
                    ),
                    const Gap(6),
                    Text(
                      state.circle.name,
                    ),
                  ],
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              color: blackAndWhite.shade900,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: PicnicImage(
                      source: PicnicImageSource.imageUrl(
                        state.imagePostContent.imageUrl,
                        fit: BoxFit.contain,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 52),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: PostSummaryBar(
                                  author: state.post.author,
                                  post: state.post,
                                  overlayTheme: state.post.overlayTheme,
                                  onToggleFollow: doNothing,
                                  onTapTag: presenter.onTapShowCircle,
                                  onTapAuthor: presenter.onTapProfile,
                                  onTapJoinCircle: presenter.onJoinCircle,
                                  showTagBackground: true,
                                  showTimestamp: true,
                                ),
                              ),
                              PostCaption(
                                text: state.imagePostContent.text,
                              ),
                              Padding(
                                padding: _contentPadding,
                                child: HorizontalPostBarButtons(
                                  likeButtonParams: PostBarLikeButtonParams(
                                    isLiked: state.post.iLiked,
                                    likes: contentStats.likes.toString(),
                                    onTap: presenter.onTapLikePost,
                                    overlayTheme: overlayTheme,
                                    isVertical: false,
                                  ),
                                  dislikeButtonParams: PostBarButtonParams(
                                    onTap: presenter.onTapDislikePost,
                                    overlayTheme: overlayTheme,
                                    selected: state.post.iDisliked,
                                    isVertical: false,
                                  ),
                                  commentsButtonParams: PostBarButtonParams(
                                    onTap: presenter.onTapChat,
                                    overlayTheme: overlayTheme,
                                    text: contentStats.comments.toString(),
                                    isVertical: false,
                                  ),
                                  shareButtonParams: PostBarButtonParams(
                                    onTap: presenter.onTapShare,
                                    overlayTheme: overlayTheme,
                                    text: contentStats.shares.toString(),
                                    isVertical: false,
                                  ),
                                  bookmarkButtonParams: PostBarButtonParams(
                                    onTap: presenter.onTapBookmark,
                                    overlayTheme: overlayTheme,
                                    text: contentStats.saves.toString(),
                                    selected: state.post.context.saved,
                                    isVertical: false,
                                  ),
                                  bookmarkEnabled: true,
                                ),
                              ),
                              const Gap(28),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

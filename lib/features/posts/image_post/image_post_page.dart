// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_overlay.dart';
import 'package:picnic_app/features/posts/widgets/post_overlay_gradient.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ImagePostPage extends StatefulWidget with HasPresenter<ImagePostPresenter> {
  const ImagePostPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ImagePostPresenter presenter;

  @override
  State<ImagePostPage> createState() => _ImagePostPageState();
}

class _ImagePostPageState extends State<ImagePostPage>
    with PresenterStateMixin<ImagePostViewModel, ImagePostPresenter, ImagePostPage> {
  PostOverlayPresenter? _overlayPresenter;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final black = theme.colors.blackAndWhite.shade900;
    final size = MediaQuery.of(context).size;
    return Material(
      child: LightStatusBar(
        child: stateObserver(
          builder: (context, state) {
            final displayOptions = state.displayOptions;
            return DecoratedBox(
              decoration: BoxDecoration(
                color: black,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: presenter.onImageTap,
                      child: PicnicImage(
                        onDoubleTap: () => _overlayPresenter?.onDoubleTapPost(),
                        source: PicnicImageSource.imageUrl(
                          state.imageContent.imageUrl,
                          fit: BoxFit.contain,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  PostOverlayGradient(
                    size: size,
                  ),
                  SafeArea(
                    bottom: displayOptions.detailsMode == PostDetailsMode.details,
                    top: displayOptions.detailsMode == PostDetailsMode.details,
                    child: PostOverlay(
                      key: ValueKey(state.post.id),
                      post: state.post,
                      displayOptions: displayOptions,
                      reportId: state.reportId,
                      maxCommentsCount: Constants.imagePostCommentsCount,
                      messenger: PostOverlayMediator(
                        reportActionTaken: presenter.reportActionTaken,
                        postUpdated: presenter.postUpdated,
                        onPresenterCreated: (presenter) => _overlayPresenter = presenter,
                        onUpdatedComments: presenter.onUpdatedComments,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

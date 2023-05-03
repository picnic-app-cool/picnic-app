import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presentation_model.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presenter.dart';
import 'package:picnic_app/features/chat/widgets/chat_video_player/chat_video_player.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_container_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FullscreenAttachmentPage extends StatefulWidget with HasPresenter<FullscreenAttachmentPresenter> {
  const FullscreenAttachmentPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final FullscreenAttachmentPresenter presenter;

  @override
  State<FullscreenAttachmentPage> createState() => _FullscreenAttachmentPageState();
}

class _FullscreenAttachmentPageState extends State<FullscreenAttachmentPage>
    with PresenterStateMixin<FullscreenAttachmentViewModel, FullscreenAttachmentPresenter, FullscreenAttachmentPage> {
  static const _captionPadding = EdgeInsets.only(bottom: 25);
  static const _buttonColorOpacity = 0.1;
  static const _buttonStartPadding = 24.0;
  static const _buttonTopPadding = 50.0;
  static const _photoMaxScale = 10.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final white = blackAndWhite.shade100;
    final black = blackAndWhite.shade900;
    final _whiteColorWithOpacity = white.withOpacity(_buttonColorOpacity);

    final authorStyle = theme.styles.caption30.copyWith(color: white);
    final timeStyle = theme.styles.caption10.copyWith(color: white);

    return LightStatusBar(
      child: Scaffold(
        backgroundColor: black,
        body: stateObserver(
          builder: (context, state) {
            final author = state.message.author.username;
            final time = state.message.formatSendAt(state.now);
            final attachments = state.message.attachments;

            return Stack(
              children: [
                PhotoViewGallery.builder(
                  builder: (_, index) => _getPhotoViewGalleryPageOptions(attachments[index]),
                  itemCount: attachments.length,
                ),
                Positioned(
                  left: _buttonStartPadding,
                  top: _buttonTopPadding,
                  child: PicnicContainerButton(
                    onTap: presenter.onTapBack,
                    buttonColor: _whiteColorWithOpacity,
                    child: Image.asset(
                      Assets.images.backArrow.path,
                      color: white,
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Padding(
                    padding: _captionPadding,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            author,
                            style: authorStyle,
                          ),
                          Text(
                            time,
                            style: timeStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _getPhotoViewGalleryPageOptions(Attachment attachment) {
    return attachment.isVideo
        ? PhotoViewGalleryPageOptions.customChild(
            child: ChatVideoPlayer(
              url: VideoUrl(attachment.url),
              heroTag: attachment.url,
              backgroundColor: Colors.black,
            ),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(attachment.url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * _photoMaxScale,
            heroAttributes: PhotoViewHeroAttributes(tag: state.message.id),
          );
  }
}

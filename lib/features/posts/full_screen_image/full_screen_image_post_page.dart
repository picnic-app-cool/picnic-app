import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_caption.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FullScreenImagePostPage extends StatefulWidget with HasInitialParams {
  const FullScreenImagePostPage({
    super.key,
    required this.initialParams,
  });

  @override
  final FullScreenImagePostInitialParams initialParams;

  @override
  State<FullScreenImagePostPage> createState() => _FullScreenImagePostPageState();
}

class _FullScreenImagePostPageState extends State<FullScreenImagePostPage>
    with PresenterStateMixinAuto<FullScreenImagePostViewModel, FullScreenImagePostPresenter, FullScreenImagePostPage> {
  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: blackAndWhite.shade900,
        backButtonIconColor: blackAndWhite.shade100,
        onTapBack: presenter.onTapBack,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: PostCaption(text: state.imagePostContent.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

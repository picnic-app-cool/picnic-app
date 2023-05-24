import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_caption.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
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
  static const _avatarSize = 24.0;
  static const _emojiSize = 12.0;

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
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

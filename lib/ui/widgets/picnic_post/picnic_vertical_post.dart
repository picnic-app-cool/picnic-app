import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/link_post/widgets/link_placeholder.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post_black_gradient.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post_gradient.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_link_post.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_poll_post.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_text_post.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicVerticalPost extends StatelessWidget {
  const PicnicVerticalPost({
    Key? key,
    required this.footer,
    required this.views,
    required this.background,
    required this.onTapView,
    required this.avatarUrl,
    required this.hideAuthorAvatar,
    this.onTapAvatar,
    this.foreground,
    this.content,
    this.padding,
    this.isSelected,
    this.onTapSelectedView,
    this.isMultiSelectionEnabled,
  }) : super(key: key);

  factory PicnicVerticalPost.text({
    required String footer,
    required int views,
    required String text,
    required LinearGradient gradient,
    required VoidCallback onTapView,
    required bool hideAuthorAvatar,
    ImageUrl avatarUrl = const ImageUrl.empty(),
    VoidCallback? onTapAvatar,
    EdgeInsetsGeometry? padding,
    bool? isSelected,
    VoidCallback? onTapSelectedView,
    bool? isMultiSelectionEnabled,
  }) =>
      PicnicVerticalPost(
        avatarUrl: avatarUrl,
        footer: footer,
        views: views,
        background: PicnicPostGradient(
          gradient: gradient,
        ),
        content: PicnicVerticalTextPost(text: text),
        onTapView: onTapView,
        hideAuthorAvatar: hideAuthorAvatar,
        onTapAvatar: onTapAvatar,
        padding: padding,
        isMultiSelectionEnabled: isMultiSelectionEnabled,
        isSelected: isSelected,
        onTapSelectedView: onTapSelectedView,
      );

  factory PicnicVerticalPost.image({
    required String footer,
    required int views,
    required ImageUrl imageUrl,
    required VoidCallback onTapView,
    required bool hideAuthorAvatar,
    ImageUrl avatarUrl = const ImageUrl.empty(),
    VoidCallback? onTapAvatar,
    EdgeInsetsGeometry? padding,
    bool? isSelected,
    VoidCallback? onTapSelectedView,
    bool? isMultiSelectionEnabled,
  }) =>
      PicnicVerticalPost(
        avatarUrl: avatarUrl,
        footer: footer,
        views: views,
        foreground: const PicnicPostBlackGradient(),
        background: PicnicImage(
          source: PicnicImageSource.url(
            imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        onTapView: onTapView,
        hideAuthorAvatar: hideAuthorAvatar,
        onTapAvatar: onTapAvatar,
        padding: padding,
        isSelected: isSelected,
        onTapSelectedView: onTapSelectedView,
        isMultiSelectionEnabled: isMultiSelectionEnabled,
      );

  factory PicnicVerticalPost.video({
    required String footer,
    required int views,
    required ImageUrl imageUrl,
    required VoidCallback onTapView,
    required bool hideAuthorAvatar,
    ImageUrl avatarUrl = const ImageUrl.empty(),
    VoidCallback? onTapAvatar,
    EdgeInsetsGeometry? padding,
    bool? isSelected,
    VoidCallback? onTapSelectedView,
    bool? isMultiSelectionEnabled,
  }) =>
      PicnicVerticalPost(
        avatarUrl: avatarUrl,
        footer: footer,
        views: views,
        foreground: const PicnicPostBlackGradient(),
        background: PicnicImage(
          source: PicnicImageSource.url(
            imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        onTapView: onTapView,
        hideAuthorAvatar: hideAuthorAvatar,
        onTapAvatar: onTapAvatar,
        isSelected: isSelected,
        onTapSelectedView: onTapSelectedView,
        isMultiSelectionEnabled: isMultiSelectionEnabled,
        padding: padding,
      );

  factory PicnicVerticalPost.link({
    required String footer,
    required int views,
    required LinkUrl link,
    required LinkMetadata linkMetadata,
    required VoidCallback onTapView,
    required bool hideAuthorAvatar,
    ImageUrl avatarUrl = const ImageUrl.empty(),
    VoidCallback? onTapAvatar,
    EdgeInsetsGeometry? padding,
    bool? isSelected,
    VoidCallback? onTapSelectedView,
    bool? isMultiSelectionEnabled,
  }) =>
      PicnicVerticalPost(
        avatarUrl: avatarUrl,
        footer: footer,
        views: views,
        foreground: const PicnicPostBlackGradient(),
        background: PicnicImage(
          source: PicnicImageSource.url(
            linkMetadata.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          placeholder: () => LinkPlaceholder(
            linkUrl: link,
          ),
        ),
        content: PicnicVerticalLinkPost(
          metadata: linkMetadata,
        ),
        onTapView: onTapView,
        hideAuthorAvatar: hideAuthorAvatar,
        onTapAvatar: onTapAvatar,
        isSelected: isSelected,
        onTapSelectedView: onTapSelectedView,
        isMultiSelectionEnabled: isMultiSelectionEnabled,
        padding: padding,
      );

  factory PicnicVerticalPost.poll({
    required String footer,
    required int views,
    required VoidCallback onTapView,
    required bool hideAuthorAvatar,
    required ImageUrl leftImageUrl,
    required ImageUrl rightImageUrl,
    ImageUrl avatarUrl = const ImageUrl.empty(),
    VoidCallback? onTapAvatar,
    EdgeInsetsGeometry? padding,
    bool? isSelected,
    VoidCallback? onTapSelectedView,
    bool? isMultiSelectionEnabled,
  }) =>
      PicnicVerticalPost(
        avatarUrl: avatarUrl,
        footer: footer,
        views: views,
        foreground: const PicnicPostBlackGradient(),
        background: PicnicVerticalPollPost(
          leftImageUrl: leftImageUrl,
          rightImageUrl: rightImageUrl,
        ),
        onTapView: onTapView,
        hideAuthorAvatar: hideAuthorAvatar,
        onTapAvatar: onTapAvatar,
        padding: padding,
        isSelected: isSelected,
        onTapSelectedView: onTapSelectedView,
        isMultiSelectionEnabled: isMultiSelectionEnabled,
      );

  final String footer;
  final int views;
  final Widget background;
  final VoidCallback onTapView;

  final VoidCallback? onTapAvatar;
  final Widget? foreground;
  final Widget? content;
  final ImageUrl avatarUrl;
  final bool hideAuthorAvatar;
  final bool? isSelected;
  final VoidCallback? onTapSelectedView;
  final bool? isMultiSelectionEnabled;
  final EdgeInsetsGeometry? padding;

  static const _borderRadius = 24.0;
  static const _avatarSize = 32.0;
  static const _selectableDistance = 24.0;
  static const _selectableSize = 40.0;
  static const _selectableBorderSize = 3.0;
  static const _selectableRadius = 10.0;
  static const _selectableOpacity = 0.6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final white = colors.blackAndWhite.shade100;
    final blueWithOpacity = colors.darkBlue.shade700.withOpacity(_selectableOpacity);

    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Stack(
        children: [
          background,
          if (foreground != null) Positioned.fill(child: foreground!),
          Positioned.fill(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (content != null) Expanded(child: content!),
                  PicnicDynamicAuthor(
                    avatar: hideAuthorAvatar
                        ? null
                        : PicnicAvatar(
                            backgroundColor: white,
                            borderColor: white,
                            size: _avatarSize,
                            boxFit: PicnicAvatarChildBoxFit.cover,
                            imageSource: PicnicImageSource.url(
                              avatarUrl,
                              fit: BoxFit.cover,
                            ),
                            placeholder: () => DefaultAvatar.user(),
                            onTap: onTapAvatar,
                          ),
                    username: footer,
                    viewsCount: views,
                    titleColor: white,
                    onUsernameTap: onTapAvatar,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTapView,
                onLongPress: onTapSelectedView,
              ),
            ),
          ),
          if (isMultiSelectionEnabled == true) ...[
            Positioned.fill(
              child: Container(
                color: blueWithOpacity,
              ),
            ),
            Positioned(
              left: _selectableDistance,
              top: _selectableDistance,
              child: Container(
                width: _selectableSize,
                height: _selectableSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_selectableRadius),
                  color: isSelected == true ? white : null,
                  border: Border.all(
                    width: _selectableBorderSize,
                    color: white,
                  ),
                ),
                child: isSelected == true
                    ? Image.asset(
                        Assets.images.check.path,
                        color: blueWithOpacity.withOpacity(1),
                      )
                    : null,
              ),
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: onTapSelectedView,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

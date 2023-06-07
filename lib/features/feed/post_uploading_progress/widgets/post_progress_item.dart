import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/render_scale_widget.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostProgressItem extends StatelessWidget {
  const PostProgressItem({
    Key? key,
    required this.model,
    required this.onTapItem,
    required this.onTapClose,
  }) : super(key: key);

  final CreatePostBackgroundCallStatus model;
  final VoidCallback onTapItem;
  final VoidCallback onTapClose;
  static const _itemHeight = 120.0;
  static const _itemWidth = 70.0;
  static const _closeButtonTopPadding = 4.0;
  static const _closeButtonRightPadding = 6.0;
  static const _cornerRadius = 8.0;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final red = colors.red.shade500;
    final white = blackAndWhite.shade100;
    final overlayColor = blackAndWhite.shade900.withOpacity(0.4);
    final loadingColor = blackAndWhite.shade500;
    final textStyle = theme.styles.caption10.copyWith(color: blackAndWhite.shade100);

    final showErrorBorder = model.isFailed;

    final infoWidget = model.when(
      inProgress: (status) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PicnicLoadingIndicator(color: loadingColor),
          const Gap(2),
          Text(
            appLocalizations.uploadPercentText(status.percentage),
            style: textStyle,
          ),
        ],
      ),
      success: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.images.uploadSuccess.path,
          ),
          const Gap(2),
          Text(
            appLocalizations.uploadSuccessText,
            style: textStyle,
          ),
        ],
      ),
      failed: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.images.uploadFailed.path,
          ),
          const Gap(2),
          Text(
            appLocalizations.uploadFailedText,
            style: textStyle,
          ),
        ],
      ),
    );

    return SizedBox(
      width: _itemWidth + _closeButtonRightPadding,
      height: _itemHeight + _closeButtonTopPadding,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: _closeButtonTopPadding),
            child: InkWell(
              onTap: onTapItem,
              child: Container(
                width: _itemWidth,
                height: _itemHeight,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
                ),
                foregroundDecoration: showErrorBorder
                    ? BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(_cornerRadius)),
                        border: Border.all(width: _borderWidth, color: red),
                      )
                    : null,
                child: Stack(
                  children: [
                    RenderScaleWidget(
                      child: PostListItem(
                        onLongPress: (_) => doNothing(),
                        post: model.entity,
                        postDetailsMode: PostDetailsMode.preview,
                        onPostUpdated: (_) => doNothing(),
                        showTimestamp: true,
                        showPostCommentBar: false,
                      ),
                    ),
                    Container(
                      color: overlayColor,
                    ),
                    Center(
                      child: infoWidget,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (model.isFailed || model.isSuccess)
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: onTapClose,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: model.isFailed ? red : white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Assets.images.uploadClose.path,
                    color: model.isFailed ? white : blackAndWhite.shade600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

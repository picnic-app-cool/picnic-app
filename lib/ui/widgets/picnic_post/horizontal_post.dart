import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/text_boundaries_resolver.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_styles.dart';

class HorizontalPost extends StatelessWidget {
  const HorizontalPost({
    required this.colors,
    required this.styles,
    required this.bodyText,
    this.onTapExpand,
    this.postSummaryBar,
  });

  final PicnicStyles styles;
  final String bodyText;
  final VoidCallback? onTapExpand;
  final PicnicColors colors;
  final Widget? postSummaryBar;
  static const _textPadding = 18.5;
  static const _postPadding = EdgeInsets.only(
    top: 16.0,
    right: 20.0,
    bottom: 20.0,
    left: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final white = colors.blackAndWhite.shade100;
    final whiteWithOpacity = white.withOpacity(Constants.opacityWhiteValue);
    const expandableRowHeight = 40.0;

    return Padding(
      padding: _postPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (postSummaryBar != null) ...[
            postSummaryBar!,
            const Gap(_textPadding),
          ],
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textStyle = styles.caption30.copyWith(
                  color: white,
                );

                final textSpan = TextSpan(
                  text: bodyText,
                  style: textStyle,
                );

                final textBoundariesResolver = TextBoundariesResolver(
                  textSpan,
                  constraints,
                );

                final textEstimatedHeight = textBoundariesResolver.calculateTextHeight(context: context);
                final textPreferredLineHeight = textBoundariesResolver.calculatePrefferedLineHeight(context: context);

                final textHeightExceedsBounds = textEstimatedHeight > constraints.maxHeight;
                final textExpandable = onTapExpand != null && textHeightExceedsBounds;
                final maxLines = ((constraints.maxHeight - expandableRowHeight) / textPreferredLineHeight).floor();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: RichText(
                        text: textSpan,
                        overflow: maxLines > 0 ? TextOverflow.ellipsis : TextOverflow.clip,
                        maxLines: maxLines > 0 ? maxLines : null,
                      ),
                    ),
                    if (textExpandable)
                      SizedBox(
                        height: expandableRowHeight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: onTapExpand,
                              child: Image.asset(
                                Assets.images.expand.path,
                                color: whiteWithOpacity,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

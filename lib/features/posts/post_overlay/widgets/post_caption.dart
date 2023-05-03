import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/expandable_link_text.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostCaption extends StatelessWidget {
  const PostCaption({
    super.key,
    required this.text,
  });

  final String text;

  static const double horizontalPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100;
    final captionStyle = theme.styles.caption20.copyWith(color: whiteColor);
    final maxWidth = MediaQuery.of(context).size.width - horizontalPadding * 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ExpandableLinkText(
        text,
        textStyle: captionStyle,
        maxLines: 1,
        maxWidth: maxWidth,
        overflow: TextOverflow.ellipsis,
        expandTextBuilder: (context, isExpanded) {
          return Text(
            isExpanded ? appLocalizations.seeLess : appLocalizations.seeMore,
            style: captionStyle.copyWith(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}

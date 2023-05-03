import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_link_post.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicLinkPastedView extends StatelessWidget {
  const PicnicLinkPastedView({
    Key? key,
    required this.onTapLink,
    required this.onTapChangeLink,
    required this.linkMetadata,
    required this.linkUrl,
  }) : super(key: key);

  final Function(LinkUrl) onTapLink;
  final VoidCallback onTapChangeLink;
  final LinkMetadata linkMetadata;
  final LinkUrl linkUrl;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final redColor = colors.red;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: PicnicLinkPost(
            onTap: onTapLink,
            linkMetadata: linkMetadata,
            linkUrl: linkUrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PicnicButton(
                title: appLocalizations.changeLinkAction,
                titleColor: redColor,
                icon: Assets.images.changeLink.path,
                onTap: onTapChangeLink,
                style: PicnicButtonStyle.outlined,
                borderColor: redColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

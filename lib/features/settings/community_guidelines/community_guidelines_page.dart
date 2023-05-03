// ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presenter.dart';
import 'package:picnic_app/features/settings/community_guidelines/widgets/unordered_text_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/text/picnic_markdown_text.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CommunityGuidelinesPage extends StatefulWidget with HasPresenter<CommunityGuidelinesPresenter> {
  const CommunityGuidelinesPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CommunityGuidelinesPresenter presenter;

  @override
  State<CommunityGuidelinesPage> createState() => _CommunityGuidelinesPageState();
}

class _CommunityGuidelinesPageState extends State<CommunityGuidelinesPage>
    with PresenterStateMixin<CommunityGuidelinesViewModel, CommunityGuidelinesPresenter, CommunityGuidelinesPage> {
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleTitle30 = theme.styles.title30;

    final appBar = PicnicAppBar(
      backgroundColor: theme.colors.blackAndWhite.shade100,
      titleText: appLocalizations.communityGuidelinesAppBarTitle,
    );

    return DarkStatusBar(
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: _padding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.communityGuidelinesHeadingOne,
                  style: textStyleTitle30,
                ),
                const Gap(8),
                PicnicMarkdownText(
                  markdownSource: appLocalizations.communityGuidelinesSectionOne,
                  onTapLink: (
                    text,
                    href,
                    title,
                  ) =>
                      presenter.onTapLink(href: href),
                ),
                const Gap(8),
                Text(
                  appLocalizations.communityGuidelinesHeadingTwo,
                  style: textStyleTitle30,
                ),
                const Gap(8),
                UnorderedTextListItem(textSrc: appLocalizations.communityGuidelinesSectionTwo),
                const Gap(8),
                Text(
                  appLocalizations.communityGuidelinesHeadingThree,
                  style: textStyleTitle30,
                ),
                const Gap(8),
                UnorderedTextListItem(textSrc: appLocalizations.communityGuidelinesSectionThree),
                const Gap(8),
                PicnicMarkdownText(
                  markdownSource: appLocalizations.communityGuidelinesSectionFour,
                  onTapLink: (
                    text,
                    href,
                    title,
                  ) =>
                      presenter.onTapLink(href: href),
                ),
                const Gap(85),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

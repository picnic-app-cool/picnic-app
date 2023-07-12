import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/share_recommendation_displayable.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presenter.dart';
import 'package:picnic_app/features/posts/post_share/widgets/post_share_action_widget.dart';
import 'package:picnic_app/features/posts/post_share/widgets/share_recommendation_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostSharePage extends StatefulWidget with HasInitialParams {
  const PostSharePage({
    Key? key,
    required this.initialParams,
  }) : super(key: key);

  @override
  final PostShareInitialParams initialParams;

  @override
  State<PostSharePage> createState() => _PostSharePageState();
}

class _PostSharePageState extends State<PostSharePage>
    with PresenterStateMixinAuto<PostShareViewModel, PostSharePresenter, PostSharePage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  static const _contentPadding = 24.0;
  static const _messageMaxLines = 3;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    controller.addListener(() => presenter.onChangedSearchText(controller.text));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final shareToTitleStyle = theme.styles.title15.copyWith(
      color: theme.colors.blackAndWhite.shade900,
    );

    final messageTextStyle = theme.styles.body10;

    final searchHintColor = theme.colors.darkBlue.shade600;

    final hintStyle = theme.styles.body0.copyWith(
      color: searchHintColor,
    );

    final messageHintStyle = messageTextStyle.copyWith(
      color: searchHintColor,
    );

    final screenSize = MediaQuery.of(context).size;
    final chatsListHeight = screenSize.height / 3;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
          child: PicnicTextInput(
            hintText: appLocalizations.sharePostMessageHint,
            maxLines: _messageMaxLines,
            inputFillColor: PicnicColors.ultraPaleGrey,
            onChanged: presenter.onMessageChanged,
            keyboardType: TextInputType.multiline,
            padding: 0,
            inputTextStyle: messageTextStyle,
            hintTextStyle: messageHintStyle,
            counterTextStyle: messageHintStyle,
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.only(left: _contentPadding),
          child: Text(
            appLocalizations.sendToTitle,
            style: shareToTitleStyle,
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
          child: PicnicSoftSearchBar(
            controller: controller,
            hintText: appLocalizations.searchFriendsContactsHint,
            focusNode: focusNode,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            hintTextStyle: hintStyle,
          ),
        ),
        SizedBox(
          height: chatsListHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
            child: stateObserver(
              builder: (context, state) {
                return PicnicPagingListView<ShareRecommendationDisplayable>(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  paginatedList: state.recommendationsList,
                  loadMore: presenter.loadMore,
                  loadingBuilder: (_) => const PicnicLoadingIndicator(),
                  separatorBuilder: (context, index) => const Gap(8),
                  itemBuilder: (context, item) => ShareRecommendationItem(
                    item: item,
                    onSendPressed: presenter.onSendPressed,
                  ),
                );
              },
            ),
          ),
        ),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.only(left: _contentPadding),
          child: Text(
            appLocalizations.shareToTitle,
            style: shareToTitleStyle,
          ),
        ),
        const Gap(8),
        stateObserver(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: state.postShareApps.foldIndexed<List<Widget>>([], (
                  index,
                  list,
                  app,
                ) {
                  return list +
                      [
                        InkWell(
                          onTap: presenter.onTapShare,
                          child: PostShareActionWidget(
                            title: app.name,
                            assetPath: app.asset,
                          ),
                        ),
                        if (index != state.postShareApps.length - 1) ...[
                          const Gap(16),
                        ],
                      ];
                }),
              ),
            );
          },
        ),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: _contentPadding),
          child: Divider(height: 1),
        ),
        const Gap(10),
        Row(
          children: [
            const Gap(24),
            InkWell(
              onTap: presenter.onTapReport,
              child: PostShareActionWidget(
                title: appLocalizations.reportAction,
                assetPath: Assets.images.shareActionReport.path,
              ),
            ),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presenter.dart';
import 'package:picnic_app/features/feed/feed_more/widgets/feed_more_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class FeedMorePage extends StatefulWidget with HasPresenter<FeedMorePresenter> {
  const FeedMorePage({
    super.key,
    required this.presenter,
  });

  static const paddingSize = 20.0;
  static const paddingBottomSize = 32.0;
  static const borderButtonWidth = 2.0;
  static const borderRadius = 50.0;

  @override
  final FeedMorePresenter presenter;

  @override
  State<FeedMorePage> createState() => _FeedMorePageState();
}

class _FeedMorePageState extends State<FeedMorePage>
    with PresenterStateMixin<FeedMoreViewModel, FeedMorePresenter, FeedMorePage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    const heightRatio = 0.8;
    return stateObserver(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * heightRatio,
          child: Padding(
            padding: const EdgeInsets.only(
              left: FeedMorePage.paddingSize,
              top: FeedMorePage.paddingSize,
              right: FeedMorePage.paddingSize,
              bottom: FeedMorePage.paddingBottomSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocalizations.feedSeeMoreBottomSheetTitle,
                  style: theme.styles.title30,
                  textAlign: TextAlign.left,
                ),
                const Gap(12),
                Text(
                  appLocalizations.feedSeeMoreBottomSheetMessage,
                  style: theme.styles.body30.copyWith(
                    color: theme.colors.blackAndWhite.shade600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Gap(10),
                Expanded(
                  child: FeedMoreListView(
                    feedsList: state.feedsList,
                    loadMore: presenter.loadMore,
                    onTapFeed: widget.presenter.onTapFeed,
                    isEmpty: state.feedsList.isEmptyNoMorePage,
                  ),
                ),
                Container(
                  color: PicnicColors.lightGrey,
                  width: double.infinity,
                  height: 1,
                ),
                const Gap(10),
                Center(
                  child: PicnicTextButton(
                    label: appLocalizations.closeAction,
                    onTap: Navigator.of(context).pop,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

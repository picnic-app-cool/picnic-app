import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/widgets/chat_avatar.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/sort_button.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/comment_report_view.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/message_report_view.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/post_report_view.dart';
import 'package:picnic_app/features/circles/domain/model/comment_report.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/post_report.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ReportsListPage extends StatefulWidget with HasPresenter<ReportsListPresenter> {
  const ReportsListPage({
    super.key,
    required this.presenter,
  });

  @override
  final ReportsListPresenter presenter;

  @override
  State<ReportsListPage> createState() => _ReportsListPageState();
}

class _ReportsListPageState extends State<ReportsListPage>
    with PresenterStateMixin<ReportsListViewModel, ReportsListPresenter, ReportsListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Scaffold(
      appBar: PicnicAppBar(
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              stateObserver(
                builder: (context, state) {
                  return PicnicCircleAvatar(
                    emoji: state.circle.emoji,
                    image: state.circle.imageFile,
                    emojiSize: Constants.emojiSize,
                    avatarSize: ChatAvatar.avatarSize,
                    bgColor: theme.colors.blackAndWhite.shade200,
                  );
                },
              ),
              const Gap(8),
              Text(appLocalizations.reportsTabAction, style: theme.styles.subtitle30),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: stateObserver(
          builder: (context, state) {
            return Column(
              children: [
                if (state.filtersEnabled)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 18.0,
                    ),
                    child: SortButton(
                      onTap: presenter.onTapFilters,
                      title: state.filterBy.valueToDisplay,
                    ),
                  ),
                const SizedBox(height: 8),
                if (state.searchEnabled)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: PicnicSoftSearchBar(
                      onChanged: presenter.onSearchTextChanged,
                      hintText: appLocalizations.chatNewMessageSearchInputHint,
                    ),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: PicnicPagingListView<ViolationReport>(
                    paginatedList: state.reports.paginatedList,
                    loadMore: presenter.onLoadMore,
                    loadingBuilder: (BuildContext context) => const Center(child: PicnicLoadingIndicator()),
                    separatorBuilder: (_, __) => const Divider(height: 24, thickness: 1),
                    itemBuilder: (context, item) {
                      switch (item.runtimeType) {
                        case PostReport:
                          final reportedPost = item as PostReport;
                          return PostReportView(
                            circleName: state.circle.name,
                            circleEmoji: state.circle.emoji,
                            circleImage: state.circle.imageFile,
                            reportedPost: reportedPost,
                            onTap: presenter.onTapReport,
                          );
                        case MessageReport:
                          final reportedPost = item as MessageReport;
                          return MessageReportView(
                            circleName: state.circle.name,
                            circleEmoji: state.circle.emoji,
                            circleImage: state.circle.imageFile,
                            reportedPost: reportedPost,
                            onTap: presenter.onTapReport,
                          );
                        case CommentReport:
                          final reportedComment = item as CommentReport;
                          return CommentReportView(
                            circleName: state.circle.name,
                            circleEmoji: state.circle.emoji,
                            circleImage: state.circle.imageFile,
                            reportedComment: reportedComment,
                            onTap: presenter.onTapReport,
                          );
                        case ViolationReport:
                          return const SizedBox.shrink();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

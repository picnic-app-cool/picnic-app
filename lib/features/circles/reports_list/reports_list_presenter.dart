import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presenter.dart';
import 'package:picnic_app/features/circles/domain/model/comment_report.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_related_chat_messages_feed_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_reports_use_case.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_report.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comment_by_id_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';

class ReportsListPresenter extends Cubit<ReportsListViewModel> {
  ReportsListPresenter(
    super.model,
    this.navigator,
    this._getReportsUseCase,
    this._getPostUseCase,
    this._getRelatedMessagesDisplayableUseCase,
    this._getCommentByIdUseCase,
    this._getCircleDetailsUseCase,
  );

  static const int relatedMessagesCount = 20;

  final ReportsListNavigator navigator;
  final GetReportsUseCase _getReportsUseCase;
  final GetPostUseCase _getPostUseCase;
  final GetRelatedChatMessagesFeedUseCase _getRelatedMessagesDisplayableUseCase;
  final GetCommentByIdUseCase _getCommentByIdUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  late final _reportsPresenter = PaginatedListPresenter<ViolationReport>(
    getPresentationModel: () => _model.reports,
    modelUpdatedCallback: (reports) => tryEmit(
      _model.copyWith(reports: reports),
    ),
    loadMoreFunction: (searchText, cursor) => _getReportsUseCase.execute(
      circleId: _model.circle.id,
      nextPageCursor: cursor,
      filterBy: _model.filterBy,
    ),
  );

  // ignore: unused_element
  ReportsListPresentationModel get _model => state as ReportsListPresentationModel;

  Future<void> onLoadMore() => _reportsPresenter.loadMore();

  Future<void> onTapReport(ViolationReport report) async {
    if (report.status == ResolveStatus.resolved) {
      await _showMoreInfoAboutResolvedReport(report);
    } else {
      await _takeActionsForUnresolvedReport(report);
    }
  }

  // TODO: https://picnic-app.atlassian.net/browse/GS-7103
  void onSearchTextChanged(String value) => notImplemented();

  Future<void> onTapFilters() async {
    final sortingOption = await _openSortScreen();

    if (sortingOption != null) {
      await _reportsPresenter.loadMore(fromScratch: true);
    }
  }

  Future<void> _showMoreInfoAboutResolvedReport(ViolationReport report) async {
    report.when(
      newPostReportReceived: (postReport) async {
        await navigator.openReportDetails(
          ResolvedReportDetailsInitialParams(
            moderator: postReport.moderator,
            resolvedAt: postReport.resolvedAt,
          ),
        );
      },
      newMessageReportReceived: (messageReport) async {
        await navigator.openReportDetails(
          ResolvedReportDetailsInitialParams(
            moderator: messageReport.moderator,
            resolvedAt: messageReport.resolvedAt,
          ),
        );
      },
      newCommentReportReceived: (commentReport) async {
        await navigator.openReportDetails(
          ResolvedReportDetailsInitialParams(
            moderator: commentReport.moderator,
            resolvedAt: commentReport.resolvedAt,
          ),
        );
      },
    );
  }

  Future<void> _takeActionsForUnresolvedReport(ViolationReport report) async {
    PostRouteResult? postRouteResult;
    bool? spammerBanned = false;
    bool? commentActionTaken = false;

    if (report is PostReport) {
      postRouteResult = await _handlePostReport(report, spammerBanned);
    } else if (report is MessageReport) {
      spammerBanned = await _handleMessageReport(report);
    } else if (report is CommentReport) {
      commentActionTaken = await _handleCommentReport(report, spammerBanned);
    }

    if (postRouteResult?.anyActionTaken == true || spammerBanned || commentActionTaken) {
      await _reportsPresenter.loadMore();
    }
  }

  Future<bool> _handleMessageReport(ViolationReport report) async {
    final messageReport = report as MessageReport;
    var spammerBanned = false;
    final circleId = _model.circle.id;
    final messageId = report.messageId;

    await _getRelatedMessagesDisplayableUseCase
        .execute(
          circleId: circleId,
          messageId: messageId,
          relatedMessagesCount: relatedMessagesCount,
        )
        .doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (relatedMessagesWithCircleDetails) async {
            spammerBanned = await navigator.openReportedMessage(
                  ReportedMessageInitialParams(
                    reportId: report.reportId,
                    circleId: circleId,
                    reportedMessageId: messageId,
                    reportedMessageAuthor: messageReport.spammer,
                    chatMessagesFeed: relatedMessagesWithCircleDetails,
                  ),
                ) ??
                false;
            if (spammerBanned) {
              await _reportsPresenter.loadMore(fromScratch: true);
            }
          },
        );
    return spammerBanned;
  }

  Future<PostRouteResult?> _handlePostReport(
    ViolationReport report,
    bool? spammerBanned,
  ) async {
    final violationReport = report as PostReport;
    final violationPostReport = violationReport.post;
    PostRouteResult? postRouteResult;
    await _getPostUseCase.execute(postId: violationPostReport.id).doOn(
          success: (post) async {
            postRouteResult = await navigator.openPostDetails(
              PostDetailsInitialParams(
                post: post,
                reportId: violationReport.reportId,
                mode: PostDetailsMode.report,
              ),
            );

            if (postRouteResult?.postRemoved == true) {
              _onCirclePostDeleted();
            }

            if (postRouteResult?.anyActionTaken == true || spammerBanned == true) {
              await _getCircleDetails();
              await _reportsPresenter.loadMore(fromScratch: true);
            }
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
    return postRouteResult;
  }

  Future<bool> _handleCommentReport(
    CommentReport report,
    bool? spammerBanned,
  ) async {
    TreeComment? reportedComment;
    await _getCommentByIdUseCase.execute(commentId: report.commentId).doOn(
          success: (comment) async {
            reportedComment = comment;
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
    if (reportedComment != null) {
      await _getPostUseCase.execute(postId: reportedComment!.postId).doOn(
            success: (post) async {
              await navigator.openCommentChat(
                CommentChatInitialParams(
                  post: post,
                  reportedComment: reportedComment,
                  reportId: report.reportId,
                ),
              );
              await _reportsPresenter.loadMore(fromScratch: true);
            },
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
      return true;
    }
    return false;
  }

  void _onCirclePostDeleted() => _model.onCirclePostDeletedCallback?.call();

  Future<void> _getCircleDetails() => _getCircleDetailsUseCase.execute(circleId: _model.circle.id).doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (circle) {
          if (_model.circle != circle) {
            tryEmit(_model.copyWith(circle: circle));
            _model.onCircleUpdatedCallback?.call();
          }
        },
      );

  Future<CircleReportsFilterBy?> _openSortScreen() async {
    final sortingOption = _model.filterBy;
    await navigator.openSortReportsBottomSheet(
      onTapSort: (reportsSortOption) {
        navigator.close();
        tryEmit(_model.copyWith(filterBy: reportsSortOption));
      },
      sortOptions: CircleReportsFilterBy.allSorts,
      selectedSortOption: _model.filterBy,
    );

    if (sortingOption != _model.filterBy) {
      return _model.filterBy;
    }
    return null;
  }
}

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class FullScreenImagePostPresenter extends Cubit<FullScreenImagePostViewModel> {
  FullScreenImagePostPresenter(
    super.model,
    this.navigator,
    this._deletePostsUseCase,
  );

  final FullScreenImagePostNavigator navigator;
  final DeletePostsUseCase _deletePostsUseCase;

  // ignore: unused_element
  FullScreenImagePostPresentationModel get _model => state as FullScreenImagePostPresentationModel;

  void onTapOptions() => navigator.onTapMore(
        onTapDeletePost: _model.canDeletePost
            ? () {
                navigator.close();
                _onTapDeletePost();
              }
            : null,
        onTapReport: _model.canReportPost ? onTapReportPost : null,
      );

  void onTapBack() => navigator.close();

  void onTapReportPost() => navigator.openReportForm(
        ReportFormInitialParams(
          entityId: _model.post.id,
          circleId: _model.post.circle.id,
          reportEntityType: ReportEntityType.post,
          contentAuthorId: _model.post.author.id,
        ),
      );

  void _onTapDeletePost() {
    navigator.close();
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.deletePost,
      message: appLocalizations.deletePostConfirmationMessage,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.deletePost,
        action: () {
          navigator.close();
          _deletePostsUseCase.execute(postIds: [_model.post.id]).doOn(
            success: (success) => navigator.closeWithResult(const PostRouteResult(postRemoved: true)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }
}

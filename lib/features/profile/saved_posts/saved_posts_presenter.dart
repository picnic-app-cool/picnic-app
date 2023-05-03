import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_saved_posts_use_case.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';

class SavedPostsPresenter extends Cubit<SavedPostsViewModel> {
  SavedPostsPresenter(
    SavedPostsPresentationModel model,
    this.navigator,
    this._getSavedPostsUseCase,
  ) : super(model);

  final SavedPostsNavigator navigator;
  final GetSavedPostsUseCase _getSavedPostsUseCase;

  SavedPostsPresentationModel get _model => state as SavedPostsPresentationModel;

  void onTapViewPost(Post post) => navigator.openPostDetails(
        PostDetailsInitialParams(
          post: post,
          onPostUpdated: (updatedPost) {
            tryEmit(_model.copyWith(posts: const PaginatedList.empty()));
            loadPosts();
          },
        ),
      );

  Future<void> loadPosts() => _getSavedPostsUseCase
      .execute(nextPageCursor: _model.posts.nextPageCursor())
      .doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (posts) => tryEmit(_model.copyWith(posts: _model.posts + posts)),
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(postsResult: result)),
      );
}

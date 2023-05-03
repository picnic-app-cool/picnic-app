import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_navigator.dart';
import 'package:picnic_app/features/profile/collection/collection_presentation_model.dart';
import 'package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/use_cases/delete_collection_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_posts_in_collection_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/remove_collection_post_use_case.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CollectionPresenter extends Cubit<CollectionViewModel> {
  CollectionPresenter(
    CollectionPresentationModel model,
    this.navigator,
    this._getPostsInCollectionUseCase,
    this._deleteCollectionUseCase,
    this._removeCollectionPostUseCase,
  ) : super(model);

  final CollectionNavigator navigator;
  final GetPostsInCollectionUseCase _getPostsInCollectionUseCase;
  final DeleteCollectionUseCase _deleteCollectionUseCase;
  final RemoveCollectionPostUseCase _removeCollectionPostUseCase;

  CollectionPresentationModel get _model => state as CollectionPresentationModel;

  void onTapClosePostsSelection() {
    _clearMultiSelectedPosts();
  }

  void onTapSelectedViewPost(Post post) {
    final newSelectedPosts = [..._model.selectedPosts];

    if (newSelectedPosts.contains(post)) {
      newSelectedPosts.remove(post);
    } else {
      newSelectedPosts.add(post);
    }

    tryEmit(
      _model.copyWith(
        selectedPosts: newSelectedPosts,
        isMultiSelectionEnabled: newSelectedPosts.isNotEmpty,
      ),
    );
  }

  void onTapConfirmPostsSelection() {
    navigator.showDeletePostConfirmation(
      title: appLocalizations.deletePostsConfirmation(_model.selectedPosts.length),
      onDelete: () {
        _onTapRemovePost();
      },
      onClose: () {
        _clearMultiSelectedPosts();
        onTapClose();
      },
    );
  }

  void onTapClose() {
    navigator.close();
  }

  Future<Either<GetPostsInCollectionFailure, PaginatedList<Post>>> loadPosts({bool fromScratch = false}) {
    _model.getCollectionPostsOperation?.cancel();

    final operation = CancelableOperation.fromFuture(
      _getPostsInCollectionUseCase.execute(
        collectionId: _model.collection.id,
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.posts.nextPageCursor(),
      ),
    );

    tryEmit(_model.copyWith(getCollectionPostsOperation: operation));

    return operation.value
        .doOn(
          success: (posts) => tryEmit(
            fromScratch
                ? _model.copyWith(posts: posts)
                : _model.byAppendingPostsList(
                    newList: posts,
                  ),
          ),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(postsResult: result)),
        );
  }

  Future<void> onTapViewPost(Post post) async {
    await navigator.openSingleFeed(
      SingleFeedInitialParams(
        preloadedPosts: _model.posts,
        initialIndex: _model.posts.indexOf(post),
        onPostsListUpdated: (posts) => tryEmit(_model.copyWith(posts: posts)),
        loadMore: () => loadPosts().mapFailure((f) => f.displayableFailure()),
        refresh: () => loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure()),
      ),
    );
  }

  void onTapActions() => navigator.showCollectionSettings(
        onDelete: () {
          onTapClose();
          _showDeleteCollectionConfirmation();
        },
      );

  void _onTapRemovePost() => {
        _removeCollectionPostUseCase
            .execute(postIds: _model.selectedPosts.map((post) => post.id).toList(), collectionId: _model.collection.id)
            .doOn(
              success: (success) {
                _clearMultiSelectedPosts();
                onTapClose();
                loadPosts(fromScratch: true);
                _model.onPostRemovedCallback?.call();
              },
              fail: (fail) => navigator.showError(fail.displayableFailure()),
            ),
      };

  void _showDeleteCollectionConfirmation() => navigator.showDeleteCollectionConfirmation(
        onDelete: _deleteCollection,
      );

  void _clearMultiSelectedPosts() {
    tryEmit(
      _model.copyWith(
        selectedPosts: [],
        isMultiSelectionEnabled: false,
      ),
    );
  }

  void _deleteCollection() {
    _deleteCollectionUseCase
        .execute(collectionId: _model.collection.id) //
        .doOn(
          success: (success) {
            _model.onPostRemovedCallback?.call();
            //close the bottom sheet
            onTapClose();

            //navigate back
            onTapClose();
          }, //
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/add_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart';

class SavePostToCollectionPresenter extends Cubit<SavePostToCollectionViewModel> {
  SavePostToCollectionPresenter(
    super.model,
    this.navigator,
    this._getCollectionsUseCase,
    this._addPostToCollectionUseCase,
  );

  final SavePostToCollectionNavigator navigator;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final AddPostToCollectionUseCase _addPostToCollectionUseCase;

  // ignore: unused_element
  SavePostToCollectionPresentationModel get _model => state as SavePostToCollectionPresentationModel;

  Future<void> loadMore({bool fromScratch = false}) {
    if (fromScratch) {
      tryEmit(_model.copyWith(postCollections: const PaginatedList.empty()));
    }
    return _getCollectionsUseCase
        .execute(
          userId: _model.userId,
          returnSavedPostsCollection: false,
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.postCollections.nextPageCursor(),
        )
        .doOn(
          success: (list) => tryEmit(
            _model.byAppendingPostCollections(list),
          ),
        );
  }

  void onTapClose() => navigator.close();

  Future<void> onTapCreateNewCollectionNavigation() async {
    final collection = await navigator.openCreateNewCollectionBottomSheet(
      const CreateNewCollectionInitialParams(),
    );
    if (collection != null) {
      tryEmit(
        _model.byAddingPostCollection(collection),
      );
    }
  }

  void onTapCollection(Collection collection) =>
      _addPostToCollectionUseCase.execute(postId: _model.postId, collectionId: collection.id).doOn(
            success: (election) => onTapClose(),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
}

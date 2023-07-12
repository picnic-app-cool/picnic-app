import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

class PaginatedListPresenter<T> {
  /// [getPresentationModel] - it's getter for PaginatedListPresentationModel stored in your PresentationModel.
  /// [modelUpdatedCallback] - this will be called when updates to PresentationModel needed.
  ///     Usually call tryEmit(_model.copyWith(.....))
  /// [loadMoreFunction] - Used to load more results by cursor.
  /// searchText may not be used by your implementation if you don't need it.
  PaginatedListPresenter({
    required PaginatedListPresentationModel<T> Function() getPresentationModel,
    required Function(PaginatedListPresentationModel<T> model) modelUpdatedCallback,
    required Future<Either<HasDisplayableFailure, PaginatedList<T>>> Function(String searchText, Cursor cursor)
        loadMoreFunction,
  })  : _getPresentationModel = getPresentationModel,
        _modelUpdatedCallback = modelUpdatedCallback,
        _loadMoreFunction = loadMoreFunction;

  final PaginatedListPresentationModel<T> Function() _getPresentationModel;
  final Function(PaginatedListPresentationModel<T> model) _modelUpdatedCallback;
  final Future<Either<HasDisplayableFailure, PaginatedList<T>>> Function(String searchText, Cursor cursor)
      _loadMoreFunction;
  final Debouncer _debouncer = getIt();

  void onChangedSearchText(String value) {
    if (value != _getPresentationModel().searchText) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          _modelUpdatedCallback(_getPresentationModel().copyWith(searchText: value));
          loadMore(fromScratch: true);
        },
      );
    }
  }

  Future<void> loadMore({bool fromScratch = false}) {
    if (!_getPresentationModel().isLoading) {
      return _loadMoreFunction(
        _getPresentationModel().searchText,
        fromScratch
            ? const Cursor.firstPage().copyWith(limit: Cursor.extendedPageSize)
            : _getPresentationModel().cursor,
      )
          .observeStatusChanges(
            (result) => _modelUpdatedCallback(_getPresentationModel().copyWith(loadingResult: result)),
          )
          .doOn(
            success: (list) => _modelUpdatedCallback(
              fromScratch
                  ? _getPresentationModel().copyWith(paginatedList: list)
                  : _getPresentationModel().byAppendingList(list),
            ),
          );
    }
    return Future.value();
  }
}

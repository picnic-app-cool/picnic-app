import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/model/selectable_app_tag.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/pods/domain/model/get_pods_tags_failure.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_pods_tags_use_case.dart';
import 'package:picnic_app/features/pods/pods_categories_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_presentation_model.dart';

class PodsCategoriesPresenter extends Cubit<PodsCategoriesViewModel> {
  PodsCategoriesPresenter(
    super.model,
    this.navigator,
    this._getPodsTagsUseCase,
    this._searchPodsUseCase,
  );

  final PodsCategoriesNavigator navigator;
  final GetPodsTagsUseCase _getPodsTagsUseCase;
  final SearchPodsUseCase _searchPodsUseCase;

  // ignore: unused_element
  PodsCategoriesPresentationModel get _model => state as PodsCategoriesPresentationModel;

  Future<void> onInit() async {
    await _getPodsTags();
    await _getPods();
  }

  Future<void> onTapTag(Selectable<AppTag> appTag) async {
    final updatedTagsList = _model.byTogglingTag(appTag.item);
    tryEmit(_model.copyWith(tagsList: updatedTagsList));
    await _getPods(fromScratch: true);
  }

  Future<void> onTapSort() async {
    final sortingOption = await _openSortScreen();

    if (sortingOption != null) {
      await _getPods(fromScratch: true);
    }
  }

  Future<void> loadMore() => _getPods();

  void onTapViewPod(PodApp pod) {
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  void onTapAddToCircle(PodApp pod) {
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  void onTapSharePod(PodApp pod) => navigator.shareText(text: pod.url);

  Future<Either<GetPodsTagsFailure, List<AppTag>>> _getPodsTags() => _getPodsTagsUseCase.execute(podsIdsList: []).doOn(
        success: (tags) => tryEmit(
          _model.copyWith(tagsList: _model.tagsList + tags.map((tag) => tag.toSelectableTag()).toList()),
        ),
      );

  Future<void> _getPods({bool fromScratch = false}) async {
    await _searchPodsUseCase
        .execute(
          input: SearchPodInput(
            cursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
            nameStartsWith: '',
            tagIds: _model.getSelectedTagsIds(),
            orderBy: _model.podSortOption,
          ),
        )
        .doOn(
          success: (newPods) {
            tryEmit(
              fromScratch ? _model.copyWith(podsList: newPods) : _model.copyWith(podsList: _model.podsList + newPods),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<AppOrder?> _openSortScreen() async {
    final sortingOption = _model.podSortOption;
    await navigator.openSortPodsBottomSheet(
      onTapSort: (podSortOption) {
        navigator.close();
        tryEmit(_model.copyWith(podSortOption: podSortOption));
      },
      sortOptions: AppOrder.allSorts,
      selectedSortOption: _model.podSortOption,
    );

    if (sortingOption != _model.podSortOption) {
      return _model.podSortOption;
    }
    return null;
  }
}

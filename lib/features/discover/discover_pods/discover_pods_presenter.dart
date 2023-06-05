import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/use_cases/get_featured_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_trending_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/un_vote_pod_failure.dart';
import 'package:picnic_app/features/circles/domain/model/vote_pod_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_vote_pod_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/vote_pod_use_case.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/pods/domain/use_cases/save_pod_use_case.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';

class DiscoverPodsPresenter extends Cubit<DiscoverPodsViewModel> {
  DiscoverPodsPresenter(
    DiscoverPodsPresentationModel model,
    this.navigator,
    this._votePodUseCase,
    this._unVotePodUseCase,
    this._getUserScopedPodTokenUseCase,
    this._getTrendingPodsUseCase,
    this._savePodUseCase,
    this._getFeaturedPodsUseCase,
    this._searchPodsUseCase,
  ) : super(model);

  final DiscoverPodsNavigator navigator;
  final VotePodUseCase _votePodUseCase;
  final UnVotePodUseCase _unVotePodUseCase;

  // ignore: unused_field
  final GetUserScopedPodTokenUseCase _getUserScopedPodTokenUseCase;
  final GetTrendingPodsUseCase _getTrendingPodsUseCase;
  final SavePodUseCase _savePodUseCase;
  final GetFeaturedPodsUseCase _getFeaturedPodsUseCase;
  final SearchPodsUseCase _searchPodsUseCase;

  DiscoverPodsPresentationModel get _model => state as DiscoverPodsPresentationModel;

  Future<Either<VotePodFailure, Unit>> onVote({required PodApp pod}) => _votePodUseCase
      .execute(
        podId: pod.id,
      ) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<Either<UnVotePodFailure, Unit>> unVot({required CirclePodApp pod}) => _unVotePodUseCase
      .execute(
        podId: pod.app.id,
      ) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<void> loadMoreTrendingPods({bool fromScratch = false}) async {
    await _getTrendingPodsUseCase
        .execute(
          cursor: fromScratch ? const Cursor.firstPage() : _model.trendingPods.nextPageCursor(),
        )
        .doOn(
          success: (trendingPods) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(trendingPods: trendingPods)
                  : _model.byAppendingTrendingPodsList(newList: trendingPods),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> loadMoreNewPods({bool fromScratch = false}) async {
    await _searchPodsUseCase
        .execute(
          input: SearchPodInput(
            cursor: fromScratch ? const Cursor.firstPage() : _model.newPods.nextPageCursor(),
            nameStartsWith: '',
            tagIds: const [],
            orderBy: AppOrder.byCreatedAt,
          ),
        )
        .doOn(
          success: (newPods) {
            tryEmit(
              fromScratch ? _model.copyWith(newPods: newPods) : _model.byAppendingNewPodsList(newList: newPods),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> loadMoreFeaturedPods({bool fromScratch = false}) async {
    await _getFeaturedPodsUseCase
        .execute(
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.featuredPods.nextPageCursor(),
        )
        .doOn(
          success: (featuredPods) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(featuredPods: featuredPods)
                  : _model.byAppendingFeaturedPodsList(newList: featuredPods),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapSearchBar() => navigator.openDiscoverSearchResults(const DiscoverSearchResultsInitialParams());

  void onTapViewCircle(Id circleId) => navigator.openCircleDetails(CircleDetailsInitialParams(circleId: circleId));

  void onTapProfile(BasicPublicProfile value) => navigator.openPublicProfile(
        PublicProfileInitialParams(userId: value.id),
      );

  void onTapViewProfile(Id id) {
    navigator.openProfile(userId: id);
  }

  Future<void> onTapSavePod(Id podId) async {
    await _savePodUseCase
        .execute(
      podId: podId,
    )
        .doOn(
      success: (result) {
        tryEmit(_model.copyWith(newPods: _model.newPods.copyWith(items: _model.bySavingNewPod(podId: podId))));

        tryEmit(
          _model.copyWith(
            trendingPods: _model.trendingPods.copyWith(items: _model.bySavingTrendingPod(podId: podId)),
          ),
        );

        tryEmit(
          _model.copyWith(
            featuredPods: _model.featuredPods.copyWith(items: _model.bySavingFeaturedPod(podId: podId)),
          ),
        );
      },
    );
  }

  Future<void> onTapViewPod(PodApp podApp) async {
    var pod = await navigator.openPodBottomSheet(PodBottomSheetInitialParams(pod: podApp));

    if (pod == null) {
      return;
    }
    tryEmit(
      _model.copyWith(trendingPods: _model.trendingPods.copyWith(items: _model.byVotingTrendingPod(podApp: pod))),
    );

    tryEmit(_model.copyWith(newPods: _model.newPods.copyWith(items: _model.byVotingNewPod(podApp: pod))));

    tryEmit(
      _model.copyWith(featuredPods: _model.featuredPods.copyWith(items: _model.byVotingFeaturedPod(podApp: pod))),
    );
  }

  void onTapAddToCircle(PodApp pod) {
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  void onTapCategories() => navigator.openPodsCategories(const PodsCategoriesInitialParams());
}

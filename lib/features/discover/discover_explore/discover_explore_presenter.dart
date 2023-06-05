import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_use_case.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/vote_pod_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_pods_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/vote_pod_use_case.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/domain/use_cases/discover_use_case.dart';
import 'package:picnic_app/features/feed/domain/model/get_popular_feed_failure.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_popular_feed_use_case.dart';
import 'package:picnic_app/features/pods/domain/use_cases/save_pod_use_case.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';

class DiscoverExplorePresenter extends Cubit<DiscoverExploreViewModel> {
  DiscoverExplorePresenter(
    DiscoverExplorePresentationModel model,
    this.navigator,
    this._discoverUseCase,
    this._popularFeedUseCase,
    this._getPodsUseCase,
    this._getChatUseCase,
    this._savePodUseCase,
    this._votePodUseCase,
  ) : super(model);

  final DiscoverExploreNavigator navigator;
  final DiscoverUseCase _discoverUseCase;
  final GetPopularFeedUseCase _popularFeedUseCase;
  final GetPodsUseCase _getPodsUseCase;
  final GetChatUseCase _getChatUseCase;
  final SavePodUseCase _savePodUseCase;
  final VotePodUseCase _votePodUseCase;

  DiscoverExplorePresentationModel get _model => state as DiscoverExplorePresentationModel;

  Future<void> init() {
    return Future.wait(
      [
        _discoverUseCase.execute().doOn(
              success: (result) => tryEmit(_model.copyWith(feedGroups: result)),
            ),
        _loadPosts(),
      ],
    );
  }

  Future<Either<VotePodFailure, Unit>> onVote({required PodApp pod}) => _votePodUseCase
      .execute(
        podId: pod.id,
      ) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<void> onTapViewPod(PodApp podApp) async {
    var pod = await navigator.openPodBottomSheet(PodBottomSheetInitialParams(pod: podApp));

    if (pod == null) {
      return;
    }
    tryEmit(_model.copyWith(pods: _model.pods.copyWith(items: _model.byVotingPod(podApp: pod))));
  }

  void onTapAddToCircle(PodApp pod) {
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    await _getPodsUseCase
        .execute(
          circleId: const Id.empty(),
          cursor: fromScratch ? const Cursor.firstPage() : _model.pods.nextPageCursor(),
        )
        .doOn(
          success: (pods) {
            tryEmit(
              fromScratch ? _model.copyWith(pods: pods) : _model.byAppendingPodsList(newList: pods),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapSearchBar() => navigator.openDiscoverSearchResults(const DiscoverSearchResultsInitialParams());

  void onTapViewPost(Post post) => navigator.openSingleFeed(
        SingleFeedInitialParams.noPagination(
          posts: _model.popularFeedPosts,
          initialIndex: _model.popularFeedPosts.indexOf(post),
          onPostsListUpdated: (posts) => tryEmit(_model.copyWith(popularFeedPosts: posts)),
          refresh: () => _loadPosts().mapFailure((f) => f.displayableFailure()),
        ),
      );

  void onTapViewCircle(Id circleId) => navigator.openCircleDetails(CircleDetailsInitialParams(circleId: circleId));

  Future<void> onTapCircleChat(Circle circle) async {
    await _getChatUseCase
        .execute(
          chatId: circle.chat.id,
        )
        .doOnSuccessWait(
          (chat) => navigator.openCircleChat(
            CircleChatInitialParams(
              chat: chat,
            ),
          ),
        );
  }

  void onTapShareCircle(Circle circle) => navigator.shareText(text: circle.shareLink);

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
          success: (result) =>
              tryEmit(_model.copyWith(pods: _model.pods.copyWith(items: _model.bySavingPod(podId: podId)))),
        );
  }

  void onTapViewPods() => navigator.openDiscoverPods(const DiscoverPodsInitialParams());

  void onTapViewCircles() => navigator.openDiscoverCircles(const DiscoverCirclesInitialParams());

  Future<Either<GetPopularFeedFailure, List<Post>>> _loadPosts() => _popularFeedUseCase.execute().doOn(
        success: (result) => tryEmit(_model.copyWith(popularFeedPosts: result.items)),
      );
}

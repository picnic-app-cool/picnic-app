import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/use_cases/get_post_creation_circles_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_navigator.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart';
import 'package:picnic_app/features/posts/select_circle/utils/post_permission_getter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class SelectCirclePresenter extends Cubit<SelectCircleViewModel> {
  SelectCirclePresenter(
    SelectCirclePresentationModel model,
    this.navigator,
    this._getPostCreationCirclesUseCase,
    this._createPostUseCase,
    this._debouncer,
  ) : super(model);

  final SelectCircleNavigator navigator;
  final GetPostCreationCirclesUseCase _getPostCreationCirclesUseCase;
  final CreatePostUseCase _createPostUseCase;
  final Debouncer _debouncer;

  SelectCirclePresentationModel get _model => state as SelectCirclePresentationModel;

  void searchChanged(String search) {
    tryEmit(_model.copyWith(searchQuery: search));
    _debouncer.debounce(
      const LongDuration(),
      () => _loadCircles(fromScratch: true),
    );
  }

  void onTapNewCircle() => navigator.openCreateCircle(
        CreateCircleInitialParams(createPostInput: _model.createPostInput),
      );

  Future<void> loadMore() async => _loadCircles(fromScratch: false);

  Future<void> onTapCircle(Circle circle) async {
    if (isPostingEnabled(postType: _model.postType, circle: circle) && circle.hasPermissionToPost) {
      await _createPostUseCase.execute(
        createPostInput: _model.createPostInput.copyWith(circleId: circle.id),
      );
      navigator.closeUntilMain();
    } else {
      await navigator.showDisabledBottomSheet(
        title: appLocalizations.postingDisabledTitle(_model.postType.value.toLowerCase()),
        description: appLocalizations.postingDisabledLabel,
        onTapClose: () => navigator.close(),
      );
    }
  }

  void onDisabledTap() => navigator.showDisabledBottomSheet(
        title: appLocalizations.postingDisabledTitle(_model.postType.value.toLowerCase()),
        description: appLocalizations.postingDisabledLabel,
        onTapClose: () => navigator.close(),
      );

  Future<void> _loadCircles({required bool fromScratch}) async {
    await _getPostCreationCirclesUseCase
        .execute(
          searchQuery: _model.searchQuery,
        ) //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(getCirclesFutureResult: result)),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (list) =>
              fromScratch ? tryEmit(_model.copyWith(circles: list)) : tryEmit(_model.byAppendingCircles(list)),
        );
  }
}

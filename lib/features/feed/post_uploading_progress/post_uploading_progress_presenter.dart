//ignore_for_file: forbidden_import_in_presentation
// TODO: remove ignore, it is here because of package:meta/meta.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_navigator.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';

class PostUploadingProgressPresenter extends Cubit<PostUploadingProgressViewModel> with SubscriptionsMixin {
  PostUploadingProgressPresenter(
    super.model,
    this.navigator,
    this._backgroundApiRepository, {
    @visibleForTesting bool avoidTimers = false,
  }) {
    listenTo<List<CreatePostBackgroundCallStatus>>(
      stream: _backgroundApiRepository.getProgressStream(),
      subscriptionId: _progressSubscription,
      onChange: _onUpdateReceived,
    );

    if (!avoidTimers) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) async {
          _checkSuccessfulUploads();
        },
      );
    }
  }

  final PostUploadingProgressNavigator navigator;
  final BackgroundApiRepository _backgroundApiRepository;
  Timer? _timer;

  static const _progressSubscription = "progressSubscription";

  // ignore: unused_element
  PostUploadingProgressPresentationModel get _model => state as PostUploadingProgressPresentationModel;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void onTapClose(CreatePostBackgroundCallStatus model) {
    model.when(
      inProgress: (_) => doNothing(),
      success: (success) {
        final statuses = [..._model.statuses]..remove(success);
        tryEmit(
          _model.copyWith(
            statuses: statuses,
          ),
        );
      },
      failed: (failed) => _backgroundApiRepository.removeBackgroundCall(id: failed.id),
    );
  }

  void onTapItem(CreatePostBackgroundCallStatus model) {
    model.when(
      inProgress: (_) => doNothing(),
      success: (status) {
        final post = status.result;
        _model.onPostToBeShown(post);
        navigator.openAfterPostModal(AfterPostDialogInitialParams(post: post));
        final statuses = [..._model.statuses]..remove(model);
        tryEmit(
          _model.copyWith(
            statuses: statuses,
          ),
        );
      },
      failed: (failed) => _backgroundApiRepository.restartBackgroundCall(id: failed.id),
    );
  }

  void _checkSuccessfulUploads() {
    const delay = PostUploadingProgressPresentationModel.successfulPostUploadVisibleSeconds;
    bool delayPassed(DateTime? time) => time != null && _model.now.difference(time).inSeconds >= delay;

    final statuses = [..._model.statuses] //
      ..removeWhere(
        (upload) => upload.isSuccess && delayPassed(_model.statusesToBeRemoved[upload.id]),
      );
    tryEmit(
      _model.copyWith(
        statuses: statuses,
      ),
    );
  }

  void _onUpdateReceived(List<CreatePostBackgroundCallStatus> list) {
    final successfulStatuses = [..._model.statuses].where((upload) => upload.isSuccess).toList();

    final statusesToBeRemoved = Map<Id, DateTime>.from(_model.statusesToBeRemoved)
      ..addEntries(
        list //
            .where((status) => status.isSuccess)
            .map((status) => MapEntry(status.id, _model.now)),
      );
    tryEmit(
      _model.copyWith(
        statuses: successfulStatuses + list,
        statusesToBeRemoved: statusesToBeRemoved,
      ),
    );

    final hasNewFailed = list.any((status) => status.isFailed && !_model.statuses.contains(status));
    if (hasNewFailed) {
      navigator.showBackgroundCallFailedToast();
    }
  }
}

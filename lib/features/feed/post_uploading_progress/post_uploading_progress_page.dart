import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/widgets/post_progress_item.dart';

class PostUploadingProgressPage extends StatefulWidget with HasInitialParams {
  const PostUploadingProgressPage({
    Key? key,
    required this.initialParams,
  }) : super(key: key);

  @override
  final PostUploadingProgressInitialParams initialParams;

  @override
  State<PostUploadingProgressPage> createState() => _PostUploadingProgressPageState();
}

class _PostUploadingProgressPageState extends State<PostUploadingProgressPage>
    with
        PresenterStateMixinAuto<PostUploadingProgressViewModel, PostUploadingProgressPresenter,
            PostUploadingProgressPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(
              top: Constants.postInFeedNavBarGapHeight + 85,
              left: Constants.defaultPadding,
              right: Constants.defaultPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.statuses
                      .map(
                        (model) => PostProgressItem(
                          model: model,
                          onTapItem: () => presenter.onTapItem(model),
                          onTapClose: () => presenter.onTapClose(model),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';

/// post overlay widget that takes care of creating the [PostOverlayPage] and two way communication
/// between the host page and the overlay
class PostOverlay extends StatefulWidget {
  const PostOverlay({
    super.key,
    required this.post,
    required this.messenger,
    required this.displayOptions,
    required this.reportId,
    this.maxCommentsCount,
  });

  final Post post;
  final PostDisplayOptions displayOptions;
  final PostOverlayMediator messenger;
  final Id reportId;
  final int? maxCommentsCount;

  @override
  State<PostOverlay> createState() => _PostOverlayState();
}

class _PostOverlayState extends State<PostOverlay> {
  late PostOverlayPage page;

  PostOverlayPresenter get presenter => page.presenter;

  @override
  void initState() {
    super.initState();
    page = getIt<PostOverlayPage>(
      param1: PostOverlayInitialParams(
        //TODO GS-3633 - add a circleId one layer above so it won't be needed to pass widget.post.circle>id but only widget.circleId
        circleId: widget.post.circle.id,
        displayOptions: widget.displayOptions,
        post: widget.post,
        messenger: widget.messenger,
        reportId: widget.reportId,
        maxCommentsCount: widget.maxCommentsCount,
      ),
    );
    widget.messenger.onPresenterCreated?.call(presenter);
  }

  @override
  void didUpdateWidget(covariant PostOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post != widget.post || oldWidget.displayOptions.detailsMode != widget.displayOptions.detailsMode) {
      presenter.didUpdateDependencies(
        post: widget.post,
        mode: widget.displayOptions.detailsMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return page;
  }
}

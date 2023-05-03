import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/multi_select_posts_confirmation.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class MultiSelectPostsComponent extends StatefulWidget {
  const MultiSelectPostsComponent({
    required this.child,
    required this.selectedPosts,
    required this.onTapClose,
    required this.onTapConfirm,
    super.key,
  });

  final Widget child;
  final List<Post> selectedPosts;
  final VoidCallback onTapClose;
  final VoidCallback onTapConfirm;

  @override
  State<MultiSelectPostsComponent> createState() => _MultiSelectPostsComponentState();
}

class _MultiSelectPostsComponentState extends State<MultiSelectPostsComponent> {
  late LayerLink _layerLink;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _layerLink = LayerLink();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const ShortDuration(), _updateOverlayEntry);

    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }

  void _createOverlayEntry(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listWidth = size.width;

    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 0,
        width: listWidth,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            color: Colors.white,
            child: MultiSelectPostsConfirmation(
              title: appLocalizations.selectPost,
              actionLabel: appLocalizations.deleteSelectedPosts(widget.selectedPosts.length),
              onTapConfirm: _onTapConfirm,
              onTapClose: _onTapClose,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlayEntry() {
    _removeOverlayEntry();
    if (widget.selectedPosts.isNotEmpty) {
      _createOverlayEntry(context);
    }
  }

  void _removeOverlayEntry() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onTapConfirm() {
    _removeOverlayEntry();
    widget.onTapConfirm();
  }

  void _onTapClose() {
    _removeOverlayEntry();
    widget.onTapClose();
  }
}

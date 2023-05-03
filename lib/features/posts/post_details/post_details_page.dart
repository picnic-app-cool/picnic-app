// ignore: unused_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presentation_model.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presenter.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostDetailsPage extends StatefulWidget with HasPresenter<PostDetailsPresenter> {
  const PostDetailsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PostDetailsPresenter presenter;

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage>
    with PresenterStateMixin<PostDetailsViewModel, PostDetailsPresenter, PostDetailsPage> {
  static const double _blur = 10.0;
  static const double _buttonColorOpacity = 0.2;
  static const double _appBarHeight = 72.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = PicnicTheme.of(context).colors;
    final _whiteColor = _theme.blackAndWhite.shade100;
    final _whiteColorWithOpacity = _whiteColor.withOpacity(_buttonColorOpacity);
    final _buttonBackdropFilter = ImageFilter.blur(
      sigmaX: _blur,
      sigmaY: _blur,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PicnicAppBar(
        height: _appBarHeight,
        backButtonBackdropFilter: state.isTransparent ? _buttonBackdropFilter : null,
        backButtonColor: state.isTransparent ? _whiteColorWithOpacity : null,
        backButtonIconColor: state.isTransparent ? _whiteColor : null,
        actions: [
          if (state.showOptions)
            PicnicContainerIconButton(
              iconPath: Assets.images.moreCircle.path,
              onTap: presenter.onUserTap,
              iconTintColor: state.isTransparent ? _whiteColor : null,
              buttonColor: state.isTransparent ? _whiteColorWithOpacity : null,
              backdropFilter: state.isTransparent ? _buttonBackdropFilter : null,
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: stateObserver(
        buildWhen: (prev, current) => prev.isLoading != current.isLoading || prev.post != current.post,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: PicnicLoadingIndicator());
          }
          return PostListItem(
            onReport: (_) => presenter.onTapReportPost(),
            post: state.post,
            reportId: state.reportId,
            postDetailsMode: state.mode,
            overlaySize: PostOverlaySize.minimized,
            onPostUpdated: presenter.onPostUpdated,
            showTimestamp: true,
          );
        },
      ),
    );
  }
}

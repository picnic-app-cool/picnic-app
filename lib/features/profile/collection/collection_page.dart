// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/collection/collection_presentation_model.dart';
import 'package:picnic_app/features/profile/collection/collection_presenter.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CollectionPage extends StatefulWidget with HasPresenter<CollectionPresenter> {
  const CollectionPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CollectionPresenter presenter;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with PresenterStateMixin<CollectionViewModel, CollectionPresenter, CollectionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Scaffold(
      appBar: PicnicAppBar(
        titleText: state.collectionName,
        actions: state.isCollectionOwner
            ? [
                PicnicContainerIconButton(
                  iconPath: Assets.images.moreCircle.path,
                  onTap: presenter.onTapActions,
                  iconTintColor: theme.colors.darkBlue.shade600,
                ),
              ]
            : null,
      ),
      body: stateObserver(
        builder: (context, state) => PreviewTab(
          onTapView: presenter.onTapViewPost,
          posts: state.posts,
          onLoadMore: presenter.loadPosts,
          postsTabType: PostsTabType.profile,
          isMultiSelectionEnabled: state.isMultiSelectionEnabled,
          selectedPosts: state.selectedPosts,
          onTapSelectedView: state.isCollectionOwner ? presenter.onTapSelectedViewPost : null,
          onTapClosePostsSelection: presenter.onTapClosePostsSelection,
          onTapConfirmPostsSelection: presenter.onTapConfirmPostsSelection,
          isLoading: state.isLoadingPosts,
        ),
      ),
    );
  }
}

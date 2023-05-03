// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presenter.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SavedPostsPage extends StatefulWidget with HasPresenter<SavedPostsPresenter> {
  const SavedPostsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SavedPostsPresenter presenter;

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage>
    with PresenterStateMixin<SavedPostsViewModel, SavedPostsPresenter, SavedPostsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final blackAndWhite = theme.colors.blackAndWhite;
    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: blackAndWhite.shade100,
          titleText: appLocalizations.savedPostsTitle,
        ),
        body: stateObserver(
          buildWhen: (previous, current) => previous.posts != current.posts,
          builder: (context, state) => PreviewTab(
            isLoading: state.isPostsLoading,
            onTapView: presenter.onTapViewPost,
            posts: state.posts,
            onLoadMore: presenter.loadPosts,
            postsTabType: PostsTabType.profile,
          ),
        ),
      ),
    );
  }
}

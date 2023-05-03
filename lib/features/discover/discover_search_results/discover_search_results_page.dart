// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presenter.dart';
import 'package:picnic_app/features/discover/discover_search_results/widgets/circles_search_result.dart';
import 'package:picnic_app/features/discover/discover_search_results/widgets/discover_search_initial_placeholder.dart';
import 'package:picnic_app/features/discover/discover_search_results/widgets/users_search_result.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_search_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class DiscoverSearchResultsPage extends StatefulWidget with HasPresenter<DiscoverSearchResultsPresenter> {
  const DiscoverSearchResultsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DiscoverSearchResultsPresenter presenter;

  @override
  State<DiscoverSearchResultsPage> createState() => _DiscoverSearchResultsPageState();
}

class _DiscoverSearchResultsPageState extends State<DiscoverSearchResultsPage>
    with
        PresenterStateMixin<DiscoverSearchResultsViewModel, DiscoverSearchResultsPresenter, DiscoverSearchResultsPage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    controller.addListener(() => presenter.onSearch(controller.text));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context).styles;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) => [
          const SliverToBoxAdapter(child: PicnicDiscoveryNavigationBar()),
          stateObserver(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => SliverToBoxAdapter(
              child: PicnicDiscoverySearchBar(
                focusNode: focusNode,
                controller: controller,
              ),
            ),
          ),
        ],
        body: stateObserver(
          builder: (context, state) {
            if (state.isInitial) {
              return DiscoverSearchInitialPlaceholder();
            }
            if (state.isLoading) {
              return const PicnicLoadingIndicator();
            }
            focusNode.unfocus();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.largePadding),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(Constants.lowPadding),
                  if (state.circles.isNotEmpty) const SliverGap(Constants.lowPadding),
                  SliverToBoxAdapter(child: Text(appLocalizations.discoveryCircleResults, style: theme.title30)),
                  CirclesSearchResult(
                    circles: state.circles,
                    onTapJoinButton: presenter.onTapJoinCircleButton,
                    onTapViewCircle: presenter.onTapViewCircle,
                  ),
                  if (state.users.isNotEmpty) const SliverGap(Constants.largePadding),
                  SliverToBoxAdapter(child: Text(appLocalizations.discoveryUserResults, style: theme.title30)),
                  UsersSearchResult(
                    onTapFollowButton: state.isLoadingToggleFollow ? null : presenter.onTapFollowButton,
                    onTapView: presenter.onTapViewProfile,
                    users: state.users,
                    showFollowButton: state.followButtonOnDiscoverPageResultsEnabled,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

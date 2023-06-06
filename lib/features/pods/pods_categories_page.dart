import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/sort_button.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_presentation_model.dart';
import 'package:picnic_app/features/pods/pods_categories_presenter.dart';
import 'package:picnic_app/features/pods/widgets/detailed_pod_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PodsCategoriesPage extends StatefulWidget with HasInitialParams {
  const PodsCategoriesPage({
    super.key,
    required this.initialParams,
  });

  @override
  final PodsCategoriesInitialParams initialParams;

  @override
  State<PodsCategoriesPage> createState() => _PodsCategoriesPageState();
}

class _PodsCategoriesPageState extends State<PodsCategoriesPage>
    with PresenterStateMixinAuto<PodsCategoriesViewModel, PodsCategoriesPresenter, PodsCategoriesPage> {
  static const tagHeight = 30.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final appBar = PicnicAppBar(
      backgroundColor: theme.colors.blackAndWhite.shade100,
      titleText: appLocalizations.podsCategories,
    );
    final darkBlue = theme.colors.darkBlue;
    final lightColor = darkBlue.shade100;
    const tagBorderWidth = 1.5;
    const tagTextHeight = 1.1;

    return stateObserver(
      builder: (context, state) => DarkStatusBar(
        child: Scaffold(
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: tagHeight,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final selectableTag = state.tagsList[index];
                      final bgColor = selectableTag.selected ? darkBlue.shade700 : lightColor;
                      final titleColor = selectableTag.selected ? lightColor : darkBlue.shade800;
                      final borderColor = selectableTag.selected ? darkBlue.shade700 : darkBlue.shade400;
                      final body10 = theme.styles.body10;
                      final titleStyle = body10.copyWith(
                        fontWeight: selectableTag.selected ? FontWeight.w500 : FontWeight.w400,
                        color: titleColor,
                      );
                      return PicnicTag(
                        title: selectableTag.item.name,
                        titleTextStyle: titleStyle,
                        backgroundColor: bgColor,
                        borderColor: borderColor,
                        borderWidth: tagBorderWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        opacity: 1.0,
                        titleHeight: tagTextHeight,
                        style: PicnicTagStyle.outlined,
                        onTap: () => presenter.onTapTag(selectableTag),
                      );
                    },
                    itemCount: state.tagsList.length,
                  ),
                ),
                const Gap(20),
                SortButton(
                  onTap: presenter.onTapSort,
                  title: state.podSortOption.valueToDisplay,
                ),
                const Gap(20),

                //TODO REVIEW THIS, we should not use CirclePodApp
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: PicnicPagingListView<CirclePodApp>(
                      paginatedList: PaginatedList(
                        items: state.podsList.items
                            .map((pod) => CirclePodApp(circleId: const Id.empty(), app: pod))
                            .toList(),
                        pageInfo: state.podsList.pageInfo,
                      ),
                      loadMore: presenter.loadMore,
                      loadingBuilder: (_) => const PicnicLoadingIndicator(),
                      separatorBuilder: (_, __) => const Gap(10),
                      itemBuilder: (context, pod) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DetailedPodWidget(
                            pod: pod.app,
                            onTapShare: () => presenter.onTapSharePod(pod.app),
                            onTapView: () => presenter.onTapViewPod(pod.app),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

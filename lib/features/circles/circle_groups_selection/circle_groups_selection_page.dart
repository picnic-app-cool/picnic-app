// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presenter.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/widgets/circle_groupings_list.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CircleGroupsSelectionPage extends StatefulWidget with HasPresenter<CircleGroupsSelectionPresenter> {
  const CircleGroupsSelectionPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleGroupsSelectionPresenter presenter;

  @override
  State<CircleGroupsSelectionPage> createState() => _CircleGroupsSelectionPageState();
}

class _CircleGroupsSelectionPageState extends State<CircleGroupsSelectionPage>
    with
        PresenterStateMixin<CircleGroupsSelectionViewModel, CircleGroupsSelectionPresenter, CircleGroupsSelectionPage> {
  static const _defaultRadius = BorderRadius.vertical(
    top: Radius.circular(22),
  );

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final _defaultPadding = EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
      bottom: bottomNavBarHeight,
    );
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final themeStyles = theme.styles;

    return Container(
      padding: _defaultPadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeColors.blackAndWhite.shade100,
        borderRadius: _defaultRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.createCircleTextInputGroupHint,
            style: themeStyles.title30,
          ),
          const Gap(16),
          stateObserver(
            builder: (context, state) {
              return SafeArea(
                child: AnimatedSwitcher(
                  duration: const ShortDuration(),
                  child: state.isLoading
                      ? const Center(child: PicnicLoadingIndicator())
                      : SingleChildScrollView(
                          child: CircleGroupingsList(
                            padding: EdgeInsets.zero,
                            circleGroups: state.circleGroups,
                            onTapCircleGrouping: presenter.onTapCircleGrouping,
                            onTapCircle: presenter.onTapCircle,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

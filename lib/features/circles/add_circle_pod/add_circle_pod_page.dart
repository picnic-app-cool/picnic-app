import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presentation_model.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presenter.dart';
import 'package:picnic_app/features/posts/select_circle/widgets/circles_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class AddCirclePodPage extends StatefulWidget with HasInitialParams {
  const AddCirclePodPage({
    super.key,
    required this.initialParams,
  });

  @override
  final AddCirclePodInitialParams initialParams;

  @override
  State<AddCirclePodPage> createState() => _AddCirclePodPageState();
}

class _AddCirclePodPageState extends State<AddCirclePodPage>
    with PresenterStateMixinAuto<AddCirclePodViewModel, AddCirclePodPresenter, AddCirclePodPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyles = theme.styles;
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.backArrow.path,
        child: Column(
          children: [
            Text(
              appLocalizations.addAction,
              style: textStyles.body30,
            ),
            Text(
              appLocalizations.selectCircleTitle,
              style: textStyles.caption10,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PicnicSoftSearchBar(
              onChanged: presenter.searchChanged,
              hintText: appLocalizations.chatNewMessageSearchInputHint,
            ),
            const Gap(16),
            Text(
              appLocalizations.circleResultsTitle,
              style: textStyles.title30,
            ),
            Expanded(
              child: stateObserver(
                buildWhen: (previous, current) => previous.circles != current.circles,
                builder: (context, state) => CirclesListView(
                  circles: state.circles,
                  loadMore: presenter.loadMore,
                  onTapCircle: presenter.onTapCircle,
                  isEmpty: state.isEmpty,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

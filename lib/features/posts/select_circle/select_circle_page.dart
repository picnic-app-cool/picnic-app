import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presenter.dart';
import 'package:picnic_app/features/posts/select_circle/widgets/circles_list_view.dart';
import 'package:picnic_app/features/posts/widgets/new_circle_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SelectCirclePage extends StatefulWidget with HasPresenter<SelectCirclePresenter> {
  const SelectCirclePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SelectCirclePresenter presenter;

  @override
  State<SelectCirclePage> createState() => _SelectCirclePageState();
}

class _SelectCirclePageState extends State<SelectCirclePage>
    with PresenterStateMixin<SelectCircleViewModel, SelectCirclePresenter, SelectCirclePage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyles = theme.styles;
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.backArrow.path,
        actions: [
          NewCircleButton(
            onTap: presenter.onTapNewCircle,
          ),
        ],
        child: Column(
          children: [
            Text(
              appLocalizations.shareToTitle,
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
              style: textStyles.subtitle40,
            ),
            Expanded(
              child: stateObserver(
                buildWhen: (previous, current) => previous.circles != current.circles,
                builder: (context, state) => CirclesListView(
                  circles: state.circles,
                  postType: state.postType,
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

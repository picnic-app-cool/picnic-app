import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/discover_pods/widgets/pod_tag.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presentation_model.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presenter.dart';
import 'package:picnic_app/features/circles/pods/widgets/picnic_web_view.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodWebViewPage extends StatefulWidget with HasInitialParams {
  const PodWebViewPage({
    super.key,
    required this.initialParams,
  });

  @override
  final PodWebViewInitialParams initialParams;

  @override
  State<PodWebViewPage> createState() => _PodWebViewPageState();
}

class _PodWebViewPageState extends State<PodWebViewPage>
    with PresenterStateMixinAuto<PodWebViewViewModel, PodWebViewPresenter, PodWebViewPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.close.path,
        backgroundColor: theme.colors.blackAndWhite.shade100,
        child: stateObserver(builder: (context, state) => PodTag(title: state.pod.name)),
      ),
      body: stateObserver(
        builder: (context, state) => PicnicWebView(url: state.pod.url),
      ),
    );
  }
}

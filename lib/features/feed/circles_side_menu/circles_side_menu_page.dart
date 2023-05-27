import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/profile/widgets/tabs/circles_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CirclesSideMenuPage extends StatefulWidget with HasInitialParams {
  const CirclesSideMenuPage({
    super.key,
    required this.initialParams,
  });

  @override
  final CirclesSideMenuInitialParams initialParams;

  @override
  State<CirclesSideMenuPage> createState() => _CirclesSideMenuPageState();
}

class _CirclesSideMenuPageState extends State<CirclesSideMenuPage>
    with PresenterStateMixinAuto<CirclesSideMenuViewModel, CirclesSideMenuPresenter, CirclesSideMenuPage> {
  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Drawer(
        elevation: 0,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  bottom: 16,
                  top: 16,
                ),
                child: Text(
                  appLocalizations.yourCircles,
                  style: PicnicTheme.of(context).styles.subtitle30,
                ),
              ),
              Flexible(
                child: stateObserver(
                  builder: (context, state) => CirclesTab(
                    onTapEnterCircle: presenter.onTapEnterCircle,
                    userCircles: state.userCircles,
                    loadMore: presenter.onLoadMoreCircles,
                    isLoading: state.isCirclesLoading,
                    onCreateNewCircleTap: presenter.onCreateNewCircleTap,
                    isMe: true,
                    onDiscoverNewCircleTap: presenter.onTapSearchCircles,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

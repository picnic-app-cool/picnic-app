// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_app/features/app_init/app_init_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/centered_picnic_logo.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class AppInitPage extends StatefulWidget with HasPresenter<AppInitPresenter> {
  const AppInitPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AppInitPresenter presenter;

  @override
  State<AppInitPage> createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage>
    with PresenterStateMixin<AppInitViewModel, AppInitPresenter, AppInitPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: stateListener(
        listener: (context, state) {
          if (state.isUserLoggedIn) {
            PicnicApp.of(context)?.setLocale(Locale(state.user.languages.first));
          }
        },
        child: CenteredPicnicLogo(
          backgroundColor: PicnicTheme.of(context).colors.blackAndWhite.shade100,
          animated: true,
          onAnimationEnd: presenter.onLogoAnimationEnd,
        ),
      ),
    );
  }
}

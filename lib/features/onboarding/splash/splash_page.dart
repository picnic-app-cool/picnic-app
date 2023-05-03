// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';
import 'package:picnic_app/features/onboarding/splash/widgets/splash_dialog_content.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/features/onboarding/widgets/splash_picnic_logo.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';

class SplashPage extends StatefulWidget with HasPresenter<SplashPresenter> {
  const SplashPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SplashPresenter presenter;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with PresenterStateMixin<SplashViewModel, SplashPresenter, SplashPage> {
  @override
  Widget build(BuildContext context) => OnboardingPageContainer(
        dialog: PicnicDialog(
          image: const SplashPicnicLogo(),
          imageStyle: PicnicDialogImageStyle.outside,
          title: appLocalizations.appTitle,
          titleSize: PicnicDialogTitleSize.large,
          description: appLocalizations.appSubtitle,
          content: SplashDialogContent(
            onTapLogin: presenter.onTapLogin,
            onTapGetStarted: presenter.onTapGetStarted,
          ),
        ),
      );
}

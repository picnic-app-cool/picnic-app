// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';
import 'package:picnic_app/features/onboarding/splash/widgets/splash_dialog_content.dart';
import 'package:picnic_app/features/onboarding/widgets/spiral.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

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
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(horizontal: 24.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Padding(
          padding: edgeInsets,
          child: Row(
            children: [
              // ignore: no-magic-number
              Assets.images.picnicLogo.image(scale: 1.5),
              const Gap(8),
              Text(appLocalizations.picnic, style: PicnicTheme.of(context).styles.display10),
            ],
          ),
        ),
        const Spiral(),
        SplashDialogContent(
          onTapLogin: presenter.onTapLogin,
          onTapGetStarted: presenter.onTapGetStarted,
        ),
        const Spacer(),
      ],
    );
  }
}

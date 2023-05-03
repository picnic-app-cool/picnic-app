import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presenter.dart';
import 'package:picnic_app/features/loading_splash/widgets/loading_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_loading_card.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LoadingSplashPage extends StatefulWidget with HasPresenter<LoadingSplashPresenter> {
  const LoadingSplashPage({
    super.key,
    required this.presenter,
  });

  @override
  final LoadingSplashPresenter presenter;

  @override
  State<LoadingSplashPage> createState() => _LoadingSplashPageState();
}

class _LoadingSplashPageState extends State<LoadingSplashPage>
    with PresenterStateMixin<LoadingSplashViewModel, LoadingSplashPresenter, LoadingSplashPage> {
  static const double _logoContainerSize = 110.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Stack(
      children: [
        const PicnicBackground(),
        LoadingPageContainer(
          dialog: PicnicDialog(
            image: PicnicAvatar(
              size: _logoContainerSize,
              showShadow: true,
              backgroundColor: theme.colors.blackAndWhite.shade100,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
            imageStyle: PicnicDialogImageStyle.outside,
            title: appLocalizations.appTitle,
            titleSize: PicnicDialogTitleSize.large,
            description: appLocalizations.appSubtitle,
            content: PicnicLoadingCard(
              title: state.title,
              description: state.description,
              circleAvatarEmoji: PicnicImageSource.emoji(state.circle.emoji),
              circleName: state.circle.name,
            ),
          ),
        ),
      ],
    );
  }
}

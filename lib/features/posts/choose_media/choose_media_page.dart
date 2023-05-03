import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/media_picker/widgets/media_grid.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_presentation_model.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChooseMediaPage extends StatefulWidget with HasPresenter<ChooseMediaPresenter> {
  const ChooseMediaPage({required this.presenter, super.key});

  @override
  final ChooseMediaPresenter presenter;

  @override
  State<ChooseMediaPage> createState() => _ChooseMediaPageState();
}

class _ChooseMediaPageState extends State<ChooseMediaPage>
    with PresenterStateMixin<ChooseMediaViewModel, ChooseMediaPresenter, ChooseMediaPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.close.path,
        child: Text(appLocalizations.chooseMediaTitle, style: theme.styles.body30),
      ),
      body: stateObserver(
        builder: (context, state) {
          return MediaGrid(
            attachments: state.attachments,
            onTap: presenter.onTapAttachment,
            loadMore: presenter.loadMoreAttachments,
          );
        },
      ),
    );
  }
}

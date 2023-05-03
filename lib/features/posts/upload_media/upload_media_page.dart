import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presenter.dart';
import 'package:picnic_app/features/posts/upload_media/widgets/upload_media_preview.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class UploadMediaPage extends StatefulWidget with HasPresenter<UploadMediaPresenter> {
  const UploadMediaPage({
    super.key,
    required this.presenter,
  });

  @override
  final UploadMediaPresenter presenter;

  @override
  State<UploadMediaPage> createState() => _UploadMediaPageState();
}

class _UploadMediaPageState extends State<UploadMediaPage>
    with PresenterStateMixin<UploadMediaViewModel, UploadMediaPresenter, UploadMediaPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: Assets.images.close.path,
        onTapBack: presenter.onTapBack,
        child: Text(appLocalizations.uploadMediaTitle, style: theme.styles.body30),
      ),
      body: stateObserver(
        builder: (context, state) {
          final content = state.createPostInput.content;
          final withCaption = state.createPostInput.withCaption;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PicnicTextInput(
                    hintText: appLocalizations.uploadMediaHint,
                    onChanged: presenter.onChangedText,
                  ),
                  const Gap(12),
                  if (withCaption)
                    UploadMediaPreview(
                      postContentInput: content,
                      onTapSwitchMedia: presenter.onTapSwitchMedia,
                    ),
                  const Gap(12),
                  PicnicButton(
                    title: appLocalizations.postAction,
                    icon: Assets.images.post.path,
                    onTap: presenter.onTapPost,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

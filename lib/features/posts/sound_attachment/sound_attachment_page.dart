import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/playable_sound.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presenter.dart';
import 'package:picnic_app/features/posts/sound_attachment/widgets/sound_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class SoundAttachmentPage extends StatefulWidget with HasPresenter<SoundAttachmentPresenter> {
  const SoundAttachmentPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SoundAttachmentPresenter presenter;

  @override
  State<SoundAttachmentPage> createState() => _SoundAttachmentPageState();
}

class _SoundAttachmentPageState extends State<SoundAttachmentPage>
    with PresenterStateMixin<SoundAttachmentViewModel, SoundAttachmentPresenter, SoundAttachmentPage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    controller.addListener(() => presenter.onTextChanged(controller.text));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PicnicAppBar(
          iconPathLeft: Assets.images.close.path,
          child: Text(
            appLocalizations.searchSoundTitle,
            style: PicnicTheme.of(context).styles.title20,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.largePadding),
              child: PicnicSoftSearchBar(
                controller: controller,
                hintText: appLocalizations.chatNewMessageSearchInputHint,
                focusNode: focusNode,
              ),
            ),
            const SizedBox(
              height: Constants.defaultPadding,
            ),
            const Divider(height: 1.0),
            Expanded(
              child: stateObserver(
                builder: (context, state) => PicnicPagingListView<PlayableSound>(
                  paginatedList: state.sounds,
                  loadMore: presenter.loadMore,
                  itemBuilder: (context, item) => SoundListItem(
                    playableSound: item,
                    onTapPlayPause: () => presenter.onTapPlayPause(item.sound),
                    onTapSelect: () => presenter.onTapSelect(sound: item.sound),
                  ),
                  loadingBuilder: (_) => const PicnicLoadingIndicator(),
                  padding: const EdgeInsets.only(top: Constants.defaultPadding),
                ),
              ),
            ),
          ],
        ),
      );
}

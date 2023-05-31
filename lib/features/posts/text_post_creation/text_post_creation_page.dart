import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posting_disabled_card.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/text_post_creation/widgets/sound_attachment_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/shake_widget.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class TextPostCreationPage extends StatefulWidget with HasPresenter<TextPostCreationPresenter> {
  const TextPostCreationPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final TextPostCreationPresenter presenter;

  @override
  State<TextPostCreationPage> createState() => _TextPostCreationPageState();
}

class _TextPostCreationPageState extends State<TextPostCreationPage>
    with PresenterStateMixin<TextPostCreationViewModel, TextPostCreationPresenter, TextPostCreationPage> {
  static const _maxLength = 10000;
  late final GlobalKey<ShakeWidgetState> _shakeWidgetKey;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _shakeWidgetKey = GlobalKey();
  }

  @override
  void dispose() {
    _shakeWidgetKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final inputTextStyle = styles.body30.copyWith(color: colors.blackAndWhite.shade800);

    return stateObserver(
      builder: (context, state) => Scaffold(
        appBar: PicnicAppBar(
          iconPathLeft: Assets.images.arrowlefttwo.path,
          actions: state.postingEnabled
              ? [
                  PicnicContainerIconButton(
                    iconPath: Assets.images.sendPost.path,
                    onTap: _onTapPost,
                  ),
                ]
              : null,
          child: Text(
            appLocalizations.shareThoughtTitle,
            style: styles.subtitle30,
          ),
        ),
        body: KeyboardActions(
          autoScroll: false,
          config: _buildConfig(context),
          child: state.postingEnabled
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state.showSelectedSoundBadge) const Gap(16),
                        if (state.showSelectedSoundBadge)
                          SoundAttachmentItem(
                            sound: state.sound,
                            onTapDeleteSoundAttachment: presenter.onTapDeleteSoundAttachment,
                          ),
                        if (state.showSelectedSoundBadge) const Gap(16),
                        PicnicTextInput(
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          maxLines: null,
                          hintText: appLocalizations.thoughtTextFieldHint,
                          maxLength: _maxLength,
                          showMaxLengthCounter: false,
                          onChanged: presenter.onTextChanged,
                          keyboardType: TextInputType.multiline,
                          padding: 0,
                          inputFillColor: Colors.transparent,
                          inputTextStyle: inputTextStyle,
                          focusNode: _focusNode,
                        ),
                      ],
                    ),
                  ),
                )
              : Center(child: PostingDisabledCard(postingType: PostType.text, circleName: state.circleName)),
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          displayArrows: false,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: colors.blue.shade700,
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  void _onTapPost() {
    if (!state.postButtonEnabled) {
      _shakeWidgetKey.currentState?.shake();
    } else {
      presenter.onTapPost();
    }
  }
}

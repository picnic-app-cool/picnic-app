// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/poll_post_creation/widgets/poll_image_selector.dart';
import 'package:picnic_app/features/posts/poll_post_creation/widgets/poll_question_input.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posting_disabled_card.dart';
import 'package:picnic_app/features/posts/text_post_creation/widgets/sound_attachment_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/shake_widget.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PollPostCreationPage extends StatefulWidget with HasPresenter<PollPostCreationPresenter> {
  const PollPostCreationPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PollPostCreationPresenter presenter;

  @override
  State<PollPostCreationPage> createState() => _PollPostCreationPageState();
}

class _PollPostCreationPageState extends State<PollPostCreationPage>
    with PresenterStateMixin<PollPostCreationViewModel, PollPostCreationPresenter, PollPostCreationPage> {
  late final GlobalKey<ShakeWidgetState> _shakeWidgetKey;

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
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          return Scaffold(
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
                appLocalizations.createPollTitle,
                style: PicnicTheme.of(context).styles.title20,
              ),
            ),
            body: SizedBox.expand(
              child: state.postingEnabled
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            if (state.showSelectedSoundBadge) ...[
                              SoundAttachmentItem(
                                sound: state.pollForm.sound,
                                onTapDeleteSoundAttachment: presenter.onTapDeleteSoundAttachment,
                              ),
                              const Gap(16),
                            ],
                            PollQuestionInput(
                              onChanged: presenter.onChangedQuestion,
                              suggestedUsersToMention: state.suggestedUsersToMention,
                              onTapSuggestedMention: presenter.onTapSuggestedMention,
                              profileStats: state.profileStats,
                              isMentionsPollPostCreationEnabled: state.isMentionsPollPostCreationEnabled,
                            ),
                            const Gap(12),
                            ShakeWidget(
                              key: _shakeWidgetKey,
                              child: PollImageSelector(
                                pollForm: state.pollForm,
                                onTapLeft: presenter.onTapLeftImage,
                                onTapRight: presenter.onTapRightImage,
                                onChanged: presenter.onChangedMention,
                                suggestedUsersToMention: state.suggestedUsersToMention,
                                onTapSuggestedMentionLeft: presenter.onTapSuggestedMentionLeft,
                                onTapSuggestedMentionRight: presenter.onTapSuggestedMentionRight,
                                isMentionsPollPostCreationEnabled: state.isMentionsPollPostCreationEnabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(child: PostingDisabledCard(postingType: PostType.poll, circleName: state.circleName)),
            ),
          );
        },
      );

  void _onTapPost() {
    if (!state.isButtonEnabled) {
      _shakeWidgetKey.currentState?.shake();
    } else {
      presenter.onTapPost();
    }
  }
}

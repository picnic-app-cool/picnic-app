// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/link_post_creation/widgets/picnic_link_empty_view.dart';
import 'package:picnic_app/features/posts/link_post_creation/widgets/picnic_link_pasted_view.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posting_disabled_card.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/shake_widget.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class LinkPostCreationPage extends StatefulWidget with HasPresenter<LinkPostCreationPresenter> {
  const LinkPostCreationPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LinkPostCreationPresenter presenter;

  @override
  State<LinkPostCreationPage> createState() => _LinkPostCreationPageState();
}

class _LinkPostCreationPageState extends State<LinkPostCreationPage>
    with PresenterStateMixin<LinkPostCreationViewModel, LinkPostCreationPresenter, LinkPostCreationPage> {
  late final GlobalKey<ShakeWidgetState> _shakeWidgetKey;

  @override
  void initState() {
    super.initState();
    _shakeWidgetKey = GlobalKey();
    presenter.navigator.context = context;
  }

  @override
  void dispose() {
    _shakeWidgetKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => stateObserver(
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
              appLocalizations.shareLinkTitle,
              style: PicnicTheme.of(context).styles.subtitle30,
            ),
          ),
          body: stateObserver(
            builder: (context, state) {
              return state.postingEnabled
                  ? AnimatedSwitcher(
                      duration: const MediumDuration(),
                      child: state.isLoadingLink
                          ? const Center(child: PicnicLoadingIndicator())
                          : state.isLinkPasted
                              ? PicnicLinkPastedView(
                                  onTapLink: presenter.onTapLink,
                                  onTapChangeLink: presenter.onTapChangeLink,
                                  linkMetadata: state.linkMetadata,
                                  linkUrl: state.linkUrl,
                                )
                              : ShakeWidget(
                                  key: _shakeWidgetKey,
                                  child: PicnicLinkEmptyView(onTapPaste: presenter.onTapPaste),
                                ),
                    )
                  : Center(
                      child: PostingDisabledCard(postingType: PostType.link, circleName: state.circleName),
                    );
            },
          ),
        ),
      );

  void _onTapPost() {
    if (!state.isLinkPasted) {
      _shakeWidgetKey.currentState?.shake();
    } else {
      presenter.onTapPost();
    }
  }
}

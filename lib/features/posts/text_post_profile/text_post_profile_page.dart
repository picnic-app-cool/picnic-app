import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_presenter.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/show_more_text.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class TextPostProfilePage extends StatefulWidget with HasPresenter<TextPostProfilePresenter> {
  const TextPostProfilePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final TextPostProfilePresenter presenter;

  @override
  State<TextPostProfilePage> createState() => _TextPostProfilePageState();
}

class _TextPostProfilePageState extends State<TextPostProfilePage>
    with PresenterStateMixin<TextPostProfileViewModel, TextPostProfilePresenter, TextPostProfilePage> {
  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final body30 = styles.body30.copyWith(color: blackAndWhite.shade900);

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return DarkStatusBar(
          child: stateObserver(
            builder: (context, state) => SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!state.showPostSummaryBarAbovePost) ...[
                    const Gap(12),
                    PostSummaryBar(
                      author: state.post.author,
                      post: state.post,
                      onToggleFollow: presenter.postOverlayPresenter.onTapFollow,
                      onTapTag: presenter.postOverlayPresenter.onTapShowCircle,
                      onTapJoinCircle: presenter.postOverlayPresenter.onJoinCircle,
                      onTapAuthor: presenter.postOverlayPresenter.onTapProfile,
                      showTagBackground: true,
                      padding: EdgeInsets.zero,
                      showTimestamp: state.showTimestamp,
                    ),
                  ],
                  const Gap(12),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints size) {
                      return ShowMoreText(
                        text: state.postContent.text,
                        style: body30,
                        maxWidth: size.maxWidth,
                        maxHeight: size.maxHeight,
                        onTapShowMore: presenter.onTapShowMore,
                      );
                    },
                  ),
                  const Gap(12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presenter.dart';
import 'package:picnic_app/features/posts/post_share/widgets/post_share_action_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostSharePage extends StatefulWidget with HasInitialParams {
  const PostSharePage({
    Key? key,
    required this.initialParams,
  }) : super(key: key);

  @override
  final PostShareInitialParams initialParams;

  @override
  State<PostSharePage> createState() => _PostSharePageState();
}

class _PostSharePageState extends State<PostSharePage>
    with PresenterStateMixinAuto<PostShareViewModel, PostSharePresenter, PostSharePage> {
  static const _contentPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final shareToTitleStyle = theme.styles.title15.copyWith(
      color: theme.colors.blackAndWhite.shade900,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(32),
        Padding(
          padding: const EdgeInsets.only(left: _contentPadding),
          child: Text(
            appLocalizations.shareToTitle,
            style: shareToTitleStyle,
          ),
        ),
        const Gap(8),
        stateObserver(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: state.postShareApps.foldIndexed<List<Widget>>([], (
                  index,
                  list,
                  app,
                ) {
                  return list +
                      [
                        InkWell(
                          onTap: presenter.onTapShare,
                          child: PostShareActionWidget(
                            title: app.name,
                            assetPath: app.asset,
                          ),
                        ),
                        if (index != state.postShareApps.length - 1) ...[
                          const Gap(16),
                        ],
                      ];
                }),
              ),
            );
          },
        ),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: _contentPadding),
          child: Divider(height: 1),
        ),
        const Gap(10),
        Row(
          children: [
            const Gap(24),
            InkWell(
              onTap: presenter.onTapReport,
              child: PostShareActionWidget(
                title: appLocalizations.reportAction,
                assetPath: Assets.images.shareActionReport.path,
              ),
            ),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}

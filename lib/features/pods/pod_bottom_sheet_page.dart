import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PodBottomSheetPage extends StatefulWidget with HasPresenter<PodBottomSheetPresenter> {
  const PodBottomSheetPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PodBottomSheetPresenter presenter;

  @override
  State<PodBottomSheetPage> createState() => _PodBottomSheetPageState();
}

class _PodBottomSheetPageState extends State<PodBottomSheetPage>
    with PresenterStateMixin<PodBottomSheetViewModel, PodBottomSheetPresenter, PodBottomSheetPage> {
  static const avatarSize = 48.0;

  static const double tagHeight = 22.0;
  static const _heightFactor = 0.36;
  static const _borderWidth = 2.0;

  static const double _tagsBorderRadius = 8.0;
  static const double _buttonsHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final styles = PicnicTheme.of(context).styles;
    final darkBlueShade700 = colors.darkBlue.shade700;
    const saveIconHeight = 14.0;
    const saveIconWidth = 10.0;

    final tagsRow = SizedBox(
      height: tagHeight,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.pod.appTags.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (BuildContext context, int index) {
          final tag = state.pod.appTags[index];
          return PicnicTag(
            opacity: 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            titleHeight: 1.0,
            title: tag.name,
            borderRadius: _tagsBorderRadius,
            backgroundColor: colors.darkBlue.shade300,
            titleTextStyle: styles.body10.copyWith(color: colors.darkBlue.shade800),
          );
        },
      ),
    );
    return stateObserver(
      builder: (context, state) {
        final counters = state.pod.counters;

        final pink = colors.pink.shade400;
        final iUpvoted = state.pod.iUpvoted;
        return FractionallySizedBox(
          heightFactor: _heightFactor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PicnicAvatar(
                      key: UniqueKey(),
                      size: avatarSize,
                      boxFit: PicnicAvatarChildBoxFit.cover,
                      imageSource: PicnicImageSource.url(
                        ImageUrl(state.pod.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.pod.name,
                            style: styles.body20,
                          ),
                          Text(
                            state.pod.owner.name,
                            style: styles.subtitle10.copyWith(color: colors.darkBlue.shade600),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () => presenter.onTapSavePod(state.pod.id),
                      child: Container(
                        width: _buttonsHeight,
                        height: _buttonsHeight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.darkBlue.shade300,
                        ),
                        child: Image.asset(
                          state.pod.iSaved ? Assets.images.saveFilled.path : Assets.images.saveOutlined.path,
                          color: darkBlueShade700,
                          height: saveIconHeight,
                          width: saveIconWidth,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.images.community.image(),
                    const Gap(8),
                    Text(
                      counters.circles.formattingToStat(),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        state.pod.description,
                        style: styles.body0.copyWith(color: darkBlueShade700),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                tagsRow,
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: PicnicButton(
                        title: appLocalizations.launchAction,
                        titleColor: Colors.white,
                        onTap: () => presenter.onTapAddToCircle(state.pod),
                        color: colors.purple,
                        icon: Assets.images.podRobot.path,
                        minWidth: double.infinity,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: PicnicButton(
                        title:
                            iUpvoted ? "unvote" : appLocalizations.votePodsLabel(counters.upvotes.formattingToStat()),
                        titleColor: iUpvoted ? pink : Colors.white,
                        icon: iUpvoted ? Assets.images.arrowDown.path : Assets.images.arrowUp.path,
                        color: iUpvoted ? Colors.white : pink,
                        borderColor: pink,
                        style: iUpvoted ? PicnicButtonStyle.outlined : PicnicButtonStyle.filled,
                        borderWidth: _borderWidth,
                        onTap: iUpvoted
                            ? () => presenter.onUnVote(pod: state.pod)
                            : () => presenter.onVote(pod: state.pod),
                        minWidth: double.infinity,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

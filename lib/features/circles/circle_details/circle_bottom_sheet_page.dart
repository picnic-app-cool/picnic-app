import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/bottom_sheet_top_indicator.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_rectangle_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CircleBottomSheetPage extends StatefulWidget with HasPresenter<CircleBottomSheetPresenter> {
  const CircleBottomSheetPage({
    super.key,
    required this.presenter,
  });

  @override
  final CircleBottomSheetPresenter presenter;

  @override
  State<CircleBottomSheetPage> createState() => _CircleBottomSheetPageState();
}

class _CircleBottomSheetPageState extends State<CircleBottomSheetPage>
    with PresenterStateMixin<CircleBottomSheetViewModel, CircleBottomSheetPresenter, CircleBottomSheetPage> {
  static const _circleAvatarSize = 56.0;
  static const _emojiSize = 28.0;
  static const _verifiedBadge = 15.0;
  static const _buttonsHeight = 40.0;
  static const _heightFactor = 0.48;
  static const _descriptionMaxLines = 3;
  static const _buttonsOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final statCountStyle = styles.subtitle10.copyWith(
      color: darkBlue.shade800,
      height: 1.0,
    );
    final statNameStyle = styles.caption10.copyWith(
      color: darkBlue.shade600,
      height: 1.0,
    );
    final buttonTextStyle = styles.link15.copyWith(color: darkBlue.shade800);
    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: stateObserver(
          builder: (context, state) {
            final iJoined = state.circle.iJoined;
            return Column(
              children: [
                BottomSheetTopIndicator(),
                const Gap(16),
                Row(
                  children: [
                    PicnicCircleRectangleAvatar(
                      avatarSize: _circleAvatarSize,
                      emojiSize: _emojiSize,
                      image: state.circle.imageFile,
                      emoji: state.circle.emoji,
                      bgColor: darkBlue.shade300,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                state.circle.name,
                                style: styles.link40.copyWith(
                                  color: darkBlue.shade800,
                                  height: 1.0,
                                ),
                              ),
                              const Gap(4),
                              Image.asset(
                                Assets.images.verBadge.path,
                                width: _verifiedBadge,
                                height: _verifiedBadge,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.circleStats.postsCount.formattingToStat(),
                                    style: statCountStyle,
                                  ),
                                  const Gap(2),
                                  Text(
                                    appLocalizations.postsTabTitle,
                                    style: statNameStyle,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    state.circleStats.viewsCount.formattingToStat(),
                                    style: statCountStyle,
                                  ),
                                  const Gap(2),
                                  Text(
                                    appLocalizations.views,
                                    style: statNameStyle,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    state.circleStats.membersCount.formattingToStat(),
                                    style: statCountStyle,
                                  ),
                                  const Gap(2),
                                  Text(
                                    appLocalizations.membersLabel,
                                    style: statNameStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Text(
                  '${state.circle.description}\n\n',
                  style: styles.body20.copyWith(color: darkBlue.shade700),
                  maxLines: _descriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: _buttonsHeight,
                        child: PicnicButton(
                          padding: EdgeInsets.zero,
                          opacity: _buttonsOpacity,
                          title: appLocalizations.chatLabel,
                          onTap: presenter.onTapChat,
                          titleStyle: buttonTextStyle,
                          color: darkBlue.shade300,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: SizedBox(
                        height: _buttonsHeight,
                        child: PicnicButton(
                          padding: EdgeInsets.zero,
                          opacity: _buttonsOpacity,
                          title: iJoined ? appLocalizations.postAction : appLocalizations.joinAction,
                          onTap: iJoined ? presenter.onTapPost : presenter.onTapJoin,
                          titleStyle: buttonTextStyle,
                          color: darkBlue.shade300,
                        ),
                      ),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: presenter.onTapShare,
                      child: Container(
                        width: _buttonsHeight,
                        height: _buttonsHeight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkBlue.shade300,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            Assets.images.uploadOutlined.path,
                            color: darkBlue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                SizedBox(
                  width: double.infinity,
                  height: _buttonsHeight,
                  child: PicnicButton(
                    padding: EdgeInsets.zero,
                    title: appLocalizations.viewCircle,
                    onTap: presenter.onTapViewCircle,
                    titleStyle: theme.styles.title10.copyWith(color: colors.blackAndWhite.shade100),
                    minWidth: double.infinity,
                    color: theme.colors.blue.shade500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

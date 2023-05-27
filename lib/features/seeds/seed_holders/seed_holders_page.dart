// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_sliver_list.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_melons_count_label.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class SeedHoldersPage extends StatefulWidget with HasPresenter<SeedHoldersPresenter> {
  const SeedHoldersPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SeedHoldersPresenter presenter;

  @override
  State<SeedHoldersPage> createState() => _SeedHoldersPageState();
}

class _SeedHoldersPageState extends State<SeedHoldersPage>
    with PresenterStateMixin<SeedHoldersViewModel, SeedHoldersPresenter, SeedHoldersPage> {
  static const _avatarSize = 40.0;
  static const _sidePadding = 24.0;
  static const _seedHolderHeight = 56.0;
  static const _iconSize = 20.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final bwShade900 = colors.blackAndWhite.shade900;

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          titleText: appLocalizations.seedHoldersTitle,
          backgroundColor: colors.blackAndWhite.shade100,
          actions: [
            PicnicContainerIconButton(
              iconPath: Assets.images.infoSquareOutlined.path,
              onTap: presenter.onTapInfo,
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            if (state.isSeedHolder) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PicnicButton(
                    title: appLocalizations.sendSeedsAction,
                    onTap: presenter.onTapSendSeeds,
                    minWidth: double.infinity,
                    icon: Assets.images.upload.path,
                  ),
                ),
              ),
              const SliverGap(24),
            ],
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: _sidePadding,
                  left: _sidePadding,
                  top: 8,
                ),
                child: Text(
                  appLocalizations.circleElectionSeedHolders,
                  style: styles.subtitle40.copyWith(
                    color: bwShade900,
                  ),
                ),
              ),
            ),
            stateObserver(
              builder: (context, state) => SliverToBoxAdapter(
                child: state.isLoading
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 8,
                        ),
                        child: PicnicMelonsCountLabel(
                          label: appLocalizations.circleElectionSeedFund,
                          labelStyle: theme.styles.body30.copyWith(
                            color: theme.colors.blackAndWhite.shade900,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Assets.images.acorn.path,
                                width: _iconSize,
                                height: _iconSize,
                              ),
                              const Gap(4),
                              Text(
                                state.seedCount.toString(),
                                style: styles.subtitle30.copyWith(color: bwShade900),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            const SliverGap(16),
            stateObserver(
              builder: (context, state) => PagingSliverList(
                paging: state.seedHolders,
                loadMore: presenter.getSeedHolders,
                loadingBuilder: (context) => const PicnicLoadingIndicator(),
                itemBuilder: (context, index) {
                  final seedHolder = state.seedHolders.items[index];
                  return PicnicListItem(
                    onTap: () => presenter.onTapUser(seedHolder.owner.id),
                    height: _seedHolderHeight,
                    leftGap: _sidePadding,
                    trailingGap: _sidePadding,
                    title: seedHolder.username,
                    titleStyle: styles.subtitle20.copyWith(
                      color: bwShade900,
                    ),
                    subTitleStyle: styles.caption10,
                    leading: PicnicAvatar(
                      boxFit: PicnicAvatarChildBoxFit.cover,
                      backgroundColor: colors.lightBlue.shade200,
                      size: _avatarSize,
                      imageSource: PicnicImageSource.url(
                        seedHolder.owner.profileImageUrl,
                        fit: BoxFit.cover,
                      ),
                      placeholder: () => DefaultAvatar.user(),
                    ),
                    trailing: Text(
                      seedHolder.amountTotal.toString(),
                      style: styles.subtitle40.copyWith(color: colors.blue.shade500),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

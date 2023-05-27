// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presenter.dart';
import 'package:picnic_app/features/seeds/widgets/seed_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class SeedsPage extends StatefulWidget with HasPresenter<SeedsPresenter> {
  const SeedsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SeedsPresenter presenter;

  @override
  State<SeedsPage> createState() => _SeedsPageState();
}

class _SeedsPageState extends State<SeedsPage> with PresenterStateMixin<SeedsViewModel, SeedsPresenter, SeedsPage> {
  static const _acornSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final styles = theme.styles;

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.seedsTitle,
          actions: [
            PicnicContainerIconButton(
              iconPath: Assets.images.infoSquareOutlined.path,
              onTap: () => presenter.onTapShowInfo(),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool _) => [
            if (state.showSendSeedsButton) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PicnicButton(
                    title: appLocalizations.sendSeedsAction,
                    onTap: presenter.onSendSeeds,
                    minWidth: double.infinity,
                    icon: Assets.images.upload.path,
                  ),
                ),
              ),
              const SliverGap(24),
            ],
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  appLocalizations.mySeedHoldings,
                  style: styles.body30,
                ),
              ),
            ),
          ],
          body: stateObserver(
            buildWhen: (previous, current) => previous.seeds != current.seeds,
            builder: (context, state) => PicnicPagingListView<Seed>(
              paginatedList: state.seeds,
              loadMore: presenter.loadSeeds,
              loadingBuilder: (_) => const PicnicLoadingIndicator(),
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, seed) {
                final trailing = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PicnicImage(
                      source: PicnicImageSource.asset(
                        ImageUrl(Assets.images.acorn.path),
                        height: _acornSize,
                        width: _acornSize,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      seed.amountTotal.formattingToStat(),
                      style: styles.subtitle40,
                    ),
                  ],
                );
                final membersCount = seed.circle.membersCount;
                final membersCountFormatted = appLocalizations.membersCount(membersCount).replaceAll(
                      membersCount.toString(),
                      membersCount.formattingToStat(),
                    );
                return SeedListItem(
                  seed: seed,
                  title: seed.circleName,
                  trailing: trailing,
                  subTitle: membersCountFormatted,
                  onTapOpenCircle: () => presenter.onTapEnterCircle(seed.circleId),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

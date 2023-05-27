// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';
import 'package:picnic_app/features/seeds/widgets/seed_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class SellSeedsFirstStepPage extends StatefulWidget with HasPresenter<SellSeedsFirstStepPresenter> {
  const SellSeedsFirstStepPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SellSeedsFirstStepPresenter presenter;

  @override
  State<SellSeedsFirstStepPage> createState() => _SellSeedsFirstStepPageState();
}

class _SellSeedsFirstStepPageState extends State<SellSeedsFirstStepPage>
    with PresenterStateMixin<SellSeedsFirstStepViewModel, SellSeedsFirstStepPresenter, SellSeedsFirstStepPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            appLocalizations.sellSeedsHoldings,
            style: theme.styles.subtitle40.copyWith(
              color: theme.colors.blackAndWhite.shade900,
            ),
          ),
        ),
        const Gap(8),
        Expanded(
          child: stateObserver(
            builder: (context, state) => PicnicPagingListView<Seed>(
              paginatedList: state.seeds,
              loadMore: presenter.getSeeds,
              loadingBuilder: (_) => const PicnicLoadingIndicator(),
              itemBuilder: (context, seed) {
                final trailing = PicnicButton(
                  title: appLocalizations.chooseAction,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  onTap: seed.amountAvailable > 0
                      ? () => presenter.onTapChoose(
                            seed,
                          )
                      : null,
                );

                return SeedListItem(
                  seed: seed,
                  title: seed.amountAvailable.formattingToStat(),
                  trailing: trailing,
                  subTitle: seed.circleName,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

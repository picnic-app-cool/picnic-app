// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/widgets/sell_seeds_second_step_bottom_panel.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/widgets/sell_seeds_second_step_form.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class SellSeedsSecondStepPage extends StatefulWidget with HasPresenter<SellSeedsSecondStepPresenter> {
  const SellSeedsSecondStepPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SellSeedsSecondStepPresenter presenter;

  @override
  State<SellSeedsSecondStepPage> createState() => _SellSeedsSecondStepPageState();
}

class _SellSeedsSecondStepPageState extends State<SellSeedsSecondStepPage>
    with PresenterStateMixin<SellSeedsSecondStepViewModel, SellSeedsSecondStepPresenter, SellSeedsSecondStepPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: stateObserver(
                      builder: (context, state) => SellSeedsSecondStepForm(
                        errorMessage: state.insufficientSeeds ? appLocalizations.insufficientSeeds : '',
                        onChangedSeedAmount: presenter.onChangedSeedAmount,
                        onTapShowRecipients: presenter.onTapShowCircleMembers,
                        selectedRecipientUserName: state.recipient.username,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            stateObserver(
              builder: (context, state) => SellSeedsSecondStepBottomPanel(
                onTap: state.sendOfferEnabled ? presenter.onTapConfirmTransfer : null,
              ),
            ),
          ],
        ),
      );
}
